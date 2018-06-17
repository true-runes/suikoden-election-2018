class InsertTweet
  def initialize
    @client = Twitter::REST::Client.new do |config|
      # 幻想水滸伝ってゲームが狂気的に面白いらしいよ？ (@tmy_development)
      config.consumer_key        = Rails.application.credentials.twitter_api[:consumer_key]
      config.consumer_secret     = Rails.application.credentials.twitter_api[:consumer_secret]
      config.access_token        = Rails.application.credentials.twitter_api[:access_token]
      config.access_token_secret = Rails.application.credentials.twitter_api[:access_token_secret]
    end
  end

  def search_tweet(search_word:, options: nil) # options
    ActiveRecord::Base.connection_pool.with_connection do |c|
      Upsert.batch(c, :search_words) do |upsert|
        upsert.row(
          {
            word: search_word,
          },
          {
            created_at: Time.now.utc,
            updated_at: Time.now.utc,
          },
        )
      end
    end

    # TODO: exception 対策（初回取得時）
    # TODO: 検索以外の手段での取得にも対応する（特定ユーザタイムライン、自分のタイムライン）
    # TODO: since_id や max_id を手動で設定（フォーム）
    latest_tweet_id = SearchWord.where(word: search_word).first.tweets.order('tweet_number DESC').first[:tweet_number].to_s
    # oldest_tweet_id = SearchWord.where(word: search_word).first.tweets.order('tweet_number ASC').first[:tweet_number].to_s

    @client.search(
      search_word,
      {
        tweet_mode: 'extended',
        result_type: 'recent',
        count: 100,
        # since_id: latest_tweet_id
      }
    ).take(100)
  end

  def mazu_upsert_users(tweet_objects, search_word: nil, user_name: nil)
    ActiveRecord::Base.connection_pool.with_connection do |c|
      Upsert.batch(c, :users) do |upsert|
        # TODO: ↓長いので外に出す
        tweet_objects.each do |tweet_object|

          user_object = tweet_object.user

          # users のところ
          upsert.row(
            {
              user_number: user_object.id,
            },
            upsert_user_hash(user_object),
          )

          # in_user_uriのところ
          user_attrs = user_object.attrs
          in_user_uri_object = user_attrs[:entities][:description][:urls]

          unless in_user_uri_object.empty?
            @bulk_insert_objects = []
            in_user_uri_object.each do |in_user_uri|
              @bulk_insert_objects << User.find_by(user_number: user_object.id).in_user_uris.new(
                uri: in_user_uri[:url],
                expanded_uri: in_user_uri[:expanded_url],
                indices: in_user_uri[:indices].to_s, # 一意性確保のためなので、正規化は考えない
              )
            end
            InUserUri.import @bulk_insert_objects
          end
        end
      end
    end
  end

  def upsert_to_tweets_table(tweet_objects, search_word: nil, user_name: nil)
    ActiveRecord::Base.connection_pool.with_connection do |c|
      Upsert.batch(c, :tweets) do |upsert|
        # TODO: ↓長いので外に出す
        tweet_objects.each do |tweet_object|
          fk_user_id = User.where(user_number: tweet_object.user.id).first.id

          upsert.row(
            {
              tweet_number: kill_nil(tweet_object.id),
            },
            {
              user_id: fk_user_id,
              has_user_mentions: kill_nil(tweet_object.user_mentions?),
              has_uris: kill_nil(tweet_object.uris?),
              has_symbols: kill_nil(tweet_object.symbols?),
              has_media: kill_nil(tweet_object.media?),
              has_hashtags: kill_nil(tweet_object.hashtags?),
              is_retweet: kill_nil(tweet_object.retweet?),
              tweeted_at: kill_nil(tweet_object.created_at),
              uri: kill_nil(tweet_object.uri.to_s),
              client_name: kill_nil(tweet_object.source),
              retweet_count: kill_nil(tweet_object.retweet_count),
              lang: kill_nil(tweet_object.lang),
              in_reply_to_user_id: kill_nil(tweet_object.in_reply_to_user_id),
              in_reply_to_status_id: kill_nil(tweet_object.in_reply_to_status_id),
              in_reply_to_screen_name: kill_nil(tweet_object.in_reply_to_screen_name),
              favorite_count: kill_nil(tweet_object.favorite_count),
              text: kill_nil(tweet_object.attrs[:full_text]),
              search_word_id: kill_nil(SearchWord.where(word: search_word).first.id),

              created_at: Time.now.utc,
              updated_at: Time.now.utc,
            },
          )

          # hashtags
          if tweet_object.hashtags?
            @bulk_insert_objects = []
            tweet_object.hashtags.each do |hashtag|
              @bulk_insert_objects << Tweet.find_by(tweet_number: tweet_object.id).hashtags.new(
                name: hashtag.text,
                indices: hashtag.indices.to_s, # 一意性確保のためなので、正規化は考えない
              )
            end
            Hashtag.import @bulk_insert_objects
          end

          # TODO: in_user_urisを作るのを忘れている
          # TODO: in_user_urisすごい難しい。UPSERTではだめDELETE&INSERTを毎回しなければ冪等でなくなる

          # has_user_mentions

          # has_uris
          if tweet_object.uris?
            @bulk_insert_objects = []
            tweet_object.uris.each do |uri|
              @bulk_insert_objects << Tweet.find_by(tweet_number: tweet_object.id).in_tweet_uris.new(
                uri: uri.expanded_url.to_s,
                indices: uri.indices.to_s, # 一意性確保のためなので、正規化は考えない
              )
            end
            InTweetUri.import @bulk_insert_objects
          end

          # has_media
          if tweet_object.media?
            @bulk_insert_objects = []
            tweet_object.media.each do |medium|

              # TODO: 切り出し
              if medium.type == 'photo'
                @thumbnail_uri = "#{medium.media_uri_https.to_s}:thumb"
              end

              @bulk_insert_objects << Tweet.find_by(tweet_number: tweet_object.id).media.new(
                medium_own_id: medium.id,
                uri: medium.media_uri_https.to_s,
                thumbnail_uri: @thumbnail_uri,
                media_type: medium.type, # TODO: enum
              )
            end
            Medium.import @bulk_insert_objects
          end
        end
      end
    end
  end


  def user
    @client.user('gensosenkyo')
  end

  def kill_nil(kill_nil_object, default_value: 'DEFAULT_VALUE')
    kill_nil_object.nil? ? default_value : kill_nil_object
  end

  # TODO: method name is kill_nil
  def maybe(maybe_object, default_value: 'DEFAULT_VALUE')
    maybe_object.nil? ? default_value : maybe_object
  end

  def users(user_ids)
    @client.users(user_ids)
  end

  def user_id_list
    max_users_per_request = 100
    # Rate Limits に注意……
    user_ids_str = User.order(user_number: :desc).pluck(:user_number)
    user_ids_int_array = user_ids_str.map { |user_id_str| user_id_str.to_i }

    divided_array = user_ids_int_array.each_slice(max_users_per_request).to_a
  end

  def debug
    user_id_list
    users(user_id_list)
  end

  def upsert_user_hash(user_object)
    my_hash = {
      # user_number: user_attrs.id, # INSERTをする際にここで指定されたカラムがすでに存在するならUPSERT扱いになる
      screen_name: kill_nil(user_object.screen_name),
      name: kill_nil(user_object.name),
      description: kill_nil(user_object.description, default_value: 'description is dead'),
      uri: kill_nil(user_object.uri.to_s), # to_s は nil 判定できないような……その一段上で判別する ?メソッド
      uri_t_co: kill_nil(user_object.attrs[:url], default_value: 't.co.is.dead'), # 場合によってnilになる……
      tweet_count: kill_nil(user_object.statuses_count),
      profile_banner_uri: kill_nil(user_object.profile_banner_uri_https('1500x500').to_s),
      profile_image_uri: kill_nil(user_object.profile_image_uri_https('400x400').to_s),
      favorite: kill_nil(user_object.favourites_count),
      followers: kill_nil(user_object.followers_count),
      followee: kill_nil(user_object.friends_count),
      listed: kill_nil(user_object.listed_count),
      language: kill_nil(user_object.lang),
      location: kill_nil(user_object.location, default_value: 'location is dead'),
      website: kill_nil(user_object.website.to_s, default_value: 'Web'),
      bg_color: kill_nil(user_object.profile_background_color),
      link_color: kill_nil(user_object.profile_link_color),
      border_color: kill_nil(user_object.profile_sidebar_border_color),
      side_color: kill_nil(user_object.profile_sidebar_fill_color),
      text_color: kill_nil(user_object.profile_text_color),
      time_zone: kill_nil(user_object.time_zone, default_value: 'time'),
      utc_offset: kill_nil(user_object.utc_offset, default_value: 'HATENA'),
      account_created_at: kill_nil(user_object.created_at),
      connections: kill_nil(user_object.connections, default_value: 'AAA'),
      email: kill_nil(user_object.email, default_value: 'BBB'),

      created_at: Time.now.utc,
      updated_at: Time.now.utc,
    }
  end
end

#   def upsert
#
#     # user_attrs = user
#
#     user_id_list.each do |user_id_array_as_max_request|
#       user_objects = users(user_id_array_as_max_request)
#
#       ActiveRecord::Base.connection_pool.with_connection do |c|
#         Upsert.batch(c, :users) do |upsert|
#           user_objects.each do |user_object|
#             upsert.row(
#               {
#                 user_number: user_object.id, # INSERTをする際にここで指定されたカラムがすでに存在するならUPSERT扱いになる
#               },
#               upsert_user_hash(user_object),
#             )
#           end
#         end
#       end
#
#       @message = 'FOOBAR'
#     end
#   end
# end
