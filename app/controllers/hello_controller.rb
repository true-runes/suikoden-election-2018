require 'upsert/active_record_upsert'

class HelloController < ApplicationController
  # include Collection

  def kiq
    HardWorker.perform_async
    @message = 'Hello, Sidekiq!'
  end

  def insert
    obj = StoreTweets.new
    @foooo = obj

    obj.insert_to_search_words('刀剣乱舞')
  end

  def ajax
  end

  def debug
    client

    ActiveRecord::Base.connection_pool.with_connection do |c|
      Upsert.batch(c, :users) do |upsert|
        all_user_numbers_in_db.each do |user_number|
          # TODO: リファクタリング必須
          begin
            user = user_object(user_number)

            upsert.row(
              { user_number: user.id },

              # TODO: should use https://github.com/FooBarWidget/default_value_for if we wanna exchange nil to DEFAULT
              {
                screen_name: user.screen_name,
                name: user.name,
                user_number: user.id,

                # TODO: if description is empty, twitter api returns nil
                description: user.description.nil? ? 'NO DESCRIPTION' : user.description,
                uri: "#{user.uri}",

                tweet_count: user.statuses_count,

                profile_banner_uri: "#{user.profile_banner_uri_https('1500x500')}".nil? ? 'NO PROFILE BANNER' : "#{user.profile_banner_uri_https('1500x500')}",
                profile_image_uri: "#{user.profile_image_uri_https('400x400')}".nil? ? 'NO PROFILE IMAGE' : "#{user.profile_image_uri_https('400x400')}",

                favorite: user.favorites_count,
                followers: user.followers_count,
                followee: user.friends_count,
                listed: user.listed_count,

                language: user.lang.nil? ? 'NO LANGUAGE' : user.lang,
                location: user.location.nil? ? 'NO LOCATION' : user.location,
                website: "#{user.website}".nil? ? 'NO WEBSITE' : "#{user.website}",

                created_at: Time.now.utc,
                updated_at: Time.now.utc,

                # deleted_at: ,

                # bg_color: user.profile_background_color.presence || '',
                # link_color: user.profile_link_color.presence || '',
                # border_color: user.profile_sidebar_border_color.presence || '',
                # side_color: user.profile_sidebar_fill_color.presence || '',
                # text_color: user.profile_text_color.presence || '',
                # time_zone: user.time_zone.presence || '',
                # utc_offset: user.utc_offset.presence || '',
                account_created_at: user.created_at,
                # connections: user.connections.presence || '',
                # email: user.email.presence || '',
              },
            )
          rescue => e
            e
          end
        end
      end
    end
  end

  def upsert
    ActiveRecord::Base.connection_pool.with_connection do |c|
      Upsert.batch(c, :users) do |upsert|
        # TODO: ツイート基準だけでなく、user_id基準での走査のメソッドを作る
        tweets_by_hashtag.each do |tweet|
          upsert.row(
            { user_number: tweet.user.id },

            # TODO: should use https://github.com/FooBarWidget/default_value_for if we wanna exchange nil to DEFAULT
            {
              screen_name: tweet.user.screen_name,
              name: tweet.user.name,
              user_number: tweet.user.id,

              # TODO: if description is empty, twitter api returns nil
              description: tweet.user.description.nil? ? 'NO DESCRIPTION' : tweet.user.description,
              uri: "#{tweet.user.uri}",

              tweet_count: tweet.user.statuses_count.presence || -1,

              profile_banner_uri: "#{tweet.user.profile_banner_uri_https('1500x500')}".nil? ? 'NO PROFILE BANNER' : "#{tweet.user.profile_banner_uri_https('1500x500')}",
              profile_image_uri: "#{tweet.user.profile_image_uri_https('400x400')}".nil? ? 'NO PROFILE IMAGE' : "#{tweet.user.profile_image_uri_https('400x400')}",

              favorite: tweet.user.favorites_count,
              followers: tweet.user.followers_count,
              followee: tweet.user.friends_count,
              listed: tweet.user.listed_count,

              language: tweet.user.lang.nil? ? 'NO LANGUAGE' : tweet.user.lang,
              location: tweet.user.location.nil? ? 'NO LOCATION' : tweet.user.location,
              website: "#{tweet.user.website}".nil? ? 'NO WEBSITE' : "#{tweet.user.tweet.user.website}",

              created_at: Time.now.utc,
              updated_at: Time.now.utc,

              # deleted_at: ,

              # bg_color: tweet.user.profile_background_color.presence || '',
              # link_color: tweet.user.profile_link_color.presence || '',
              # border_color: tweet.user.profile_sidebar_border_color.presence || '',
              # side_color: tweet.user.profile_sidebar_fill_color.presence || '',
              # text_color: tweet.user.profile_text_color.presence || '',
              # time_zone: tweet.user.time_zone.presence || '',
              # utc_offset: tweet.user.utc_offset.presence || '',
              account_created_at: tweet.user.created_at,
              # connections: tweet.user.connections.presence || '',
              # email: tweet.user.email.presence || '',
            },
          )
        end
      end
    end
  end


  def index
    rows = [
      [
        'Alvin',
        'Eclair',
        '$0.87',
      ],
      [
        'Alan',
        'J ellybean',
        '$3.76',
      ],
      [
        'Jonathan',
        'Lollipop',
        '$7.00',
      ],
      [
        'Shannon',
        'Eclair',
        "123.00",
      ],
      [
        MyConstants::MY_NAME,
        MyConstants::MY_FAVORITE_GAME,
        "456.00",
      ],
    ]

    # Sidekiq
    # HardWorker.perform_async('bob', 5)

    @headers = ['screen_name', 'tweet_text', 'tweet_id' ,'created_at']
    @return_value = rows
    # @tweets = tweets_by_hashtag
  end
end
