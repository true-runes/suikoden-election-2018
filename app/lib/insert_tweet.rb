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

  def as_insert
    Tweet.find_by(id: 430)
  end

  def search_user(search_user:, options:)

  end

  # https://www.rubydoc.info/gems/twitter/Twitter/REST/Search#search-instance_method
  def search_tweet(search_word:, options: nil) # options
    # search_wordsテーブルにUPSERTする
    # enum……はふさわしくない enumははじめから種別がかっつり決まっているたとえば性別や都道府県などにもちいるものだ

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

    # TODO: その検索条件（やツイート取得条件）での最古のIDや最新のIDを取得すること
    # アソシエーションをたどる場合は「親」から。
    begin
      max_id = SearchWord.where(word: search_word).first.tweets.order('tweet_number ASC').first[:tweet_number].to_s
    rescue => e
      max_id = nil
    end

    begin
      # @client.search(search_word, { tweet_mode: 'extended', count: 100, max_id: max_id }).take(100)
      @client.search(search_word, { tweet_mode: 'extended', count: 100 }).take(100)
    rescue => e # Twitter::Error::TooManyRequests at /practice Rate limit exceeded
      p e
      puts "Rate Limits..."
    end
  end

  # user_id: kill_nil(tweet_object.user.id),
  def mazu_upsert_users(tweet_objects, search_word: nil, user_name: nil)
    ActiveRecord::Base.connection_pool.with_connection do |c|
      Upsert.batch(c, :users) do |upsert|
        tweet_objects.each do |tweet_object|
          user_object = tweet_object.user

          upsert.row(
            {
              user_number: user_object.id, # INSERTをする際にここで指定されたカラムがすでに存在するならUPSERT扱いになる
            },
            upsert_user_hash(user_object),
          )
        end
      end
    end
  end

  def upsert_to_tweets_table(tweet_objects, search_word: nil, user_name: nil)
    ActiveRecord::Base.connection_pool.with_connection do |c|
      Upsert.batch(c, :tweets) do |upsert|
        tweet_objects.each do |tweet_object|
          # TODO: Active Record 使っているのにこれいる？
          foreign_key_user_id = User.where(user_number: tweet_object.user.id).first.id

          begin
            upsert.row(
              {
                tweet_number: kill_nil(tweet_object.id),
              },
              {
                user_id: kill_nil(foreign_key_user_id),
                has_user_mentions: kill_nil(tweet_object.user_mentions?),
                has_uris: kill_nil(tweet_object.uris?),
                has_symbols: kill_nil(tweet_object.symbols?),
                has_media: kill_nil(tweet_object.media?),
                has_hashtags: kill_nil(tweet_object.hashtags?),
                is_retweet: kill_nil(tweet_object.retweet?),
                tweeted_at: kill_nil(tweet_object.created_at),
                uri: kill_nil(tweet_object.uri.to_s),
                uri_t_co: 't_co_is_nothing',
                # uri_t_co: kill_nil(tweet_object.id), # ツイートのURIはt.coに略されることはない
                client_name: kill_nil(tweet_object.source),
                retweet_count: kill_nil(tweet_object.retweet_count),
                lang: kill_nil(tweet_object.lang),
                in_reply_to_user_id: kill_nil(tweet_object.in_reply_to_user_id),
                in_reply_to_status_id: kill_nil(tweet_object.in_reply_to_status_id),
                in_reply_to_screen_name: kill_nil(tweet_object.in_reply_to_screen_name),
                favorite_count: kill_nil(tweet_object.favorite_count),
                text: kill_nil(tweet_object.attrs[:full_text]),
                # deleted_at: kill_nil(tweet_object.id),
                search_word_id: kill_nil(SearchWord.where(word: search_word).first.id),

                created_at: Time.now.utc,
                updated_at: Time.now.utc,
              },
            )
          rescue => exception
            p exception
          end

          # hashtags
          if tweet_object.hashtags?
            tweet_object.hashtags.each do |hashtag|
              # TODO: バルクで入れたい
              Tweet.find_by(tweet_number: tweet_object.id).hashtags.create(
                name: hashtag.text
              )
            end
          end

          # has_user_mentions
          if tweet_object.hashtags?
            tweet_object.hashtags.each do |hashtag|
              # TODO: バルクで入れたい
              Tweet.find_by(tweet_number: tweet_object.id).hashtags.create(
                name: hashtag.text
              )
            end
          end

          # has_uris
          if tweet_object.hashtags?
            tweet_object.hashtags.each do |hashtag|
              # TODO: バルクで入れたい
              Tweet.find_by(tweet_number: tweet_object.id).hashtags.create(
                name: hashtag.text
              )
            end
          end

          # has_symbols
          if tweet_object.hashtags?
            tweet_object.hashtags.each do |hashtag|
              # TODO: バルクで入れたい
              Tweet.find_by(tweet_number: tweet_object.id).hashtags.create(
                name: hashtag.text
              )
            end
          end

          # has_media
          if tweet_object.hashtags?
            tweet_object.hashtags.each do |hashtag|
              # TODO: バルクで入れたい
              Tweet.find_by(tweet_number: tweet_object.id).hashtags.create(
                name: hashtag.text
              )
            end
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
      uri: kill_nil(user_object.uri.to_s), # to_s は nil 判定できないような……
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
      website: kill_nil(user_object.connections, default_value: 'Web'),
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

      created_at: Time.now.utc, # created_at は UPDATE されないようだ（うまくできてるが、ちゃんとドキュメントを読んで確信を得る）
      updated_at: Time.now.utc, # updated_at は UPSERT の datetime に更新される
    }
  end

  def upsert

    # user_attrs = user

    user_id_list.each do |user_id_array_as_max_request|
      user_objects = users(user_id_array_as_max_request)

      ActiveRecord::Base.connection_pool.with_connection do |c|
        Upsert.batch(c, :users) do |upsert|
          user_objects.each do |user_object|
            upsert.row(
              {
                user_number: user_object.id, # INSERTをする際にここで指定されたカラムがすでに存在するならUPSERT扱いになる
              },
              upsert_user_hash(user_object),
            )
          end
        end
      end

      @message = 'FOOBAR'
    end
  end
end

    # ActiveRecord::Base.connection_pool.with_connection do |c| # 決まり文句
#     ActiveRecord::Base.connection_pool.with_connection do |c|
#       Upsert.batch(c, :users) do |upsert|
#         upsert.row(
#           {
#             user_number: user_attrs.id, # INSERTをする際にここで指定されたカラムがすでに存在するならUPSERT扱いになる
#           },
#           {
#             screen_name: user_attrs.screen_name,
#             name: user_attrs.name,
#             description: user_attrs.description,
#             uri: user_attrs.uri,
#             uri_t_co: user_attrs.attrs[:url],
#             tweet_count: user_attrs.statuses_count,
#             profile_banner_uri: user_attrs.profile_banner_uri_https('').to_s,
#             profile_image_uri: user_attrs.profile_image_uri_https('').to_s,
#             favorite: user_attrs.favourites_count,
#             followers: user_attrs.followers_count,
#             followee: user_attrs.friends_count,
#             listed: user_attrs.listed_count,
#             language: user_attrs.lang,
#             location: user_attrs.location,
#             website: 'FOOBAR', # user_attrs.website, # website? で判別してからにするべき
#             # created_at:
#             # updated_at:
#             # deleted_at:
#             bg_color: user_attrs.profile_background_color,
#             link_color: user_attrs.profile_link_color,
#             border_color: user_attrs.profile_sidebar_border_color,
#             side_color: user_attrs.profile_sidebar_fill_color,
#             text_color: user_attrs.profile_text_color,
#             time_zone: user_attrs.time_zone,
#             utc_offset: user_attrs.utc_offset,
#             account_created_at: user_attrs.created_at,
#             connections: 'FOOBAR', # user_attrs.connections, # Array
#             email: user_attrs.email,
#
#             created_at: Time.now.utc, # created_at は UPDATE されないようだ（うまくできてるが、ちゃんとドキュメントを読んで確信を得る）
#             updated_at: Time.now.utc, # updated_at は UPSERT の datetime に更新される
#           }
#         )
#       end
#     end
#   end
# end

# obj = InsertTweet.new
# pp obj.user.uri.to_s

