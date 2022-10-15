# frozen_string_literal: true

# rubocop:disable Rails/SkipsModelValidations
module TwitterApi
  module Tasks
    class UpsertSpecificUserTimeline
      def self.execute(user_id: nil, screen_name: nil, options: {})
        # TODO: user_id で取得するロジックがまだ無い
        target_tweet_objects = TwitterApi::SpecificUserTimeline.execute(user_id:, screen_name:,
                                                                        options:)
        target_user_objects = TwitterApi::ExchangeTweetToUser.execute(target_tweet_objects)

        # 下の2つの順番には依存性がある
        TwitterApi::UpsertObjects::UsersTable.upsert(target_user_objects)
        TwitterApi::UpsertObjects::TweetsTable.upsert(target_tweet_objects)

        TwitterApi::UpsertObjects::InUserUrisTable.upsert(target_user_objects)
        TwitterApi::UpsertObjects::HashtagsTable.upsert(target_tweet_objects)
        TwitterApi::UpsertObjects::InTweetUrisTable.upsert(target_tweet_objects)
        TwitterApi::UpsertObjects::MediaTable.upsert(target_tweet_objects)
      end

      def self.execute_continuously(user_id: nil, screen_name: nil, options: {})
        since_id = Tweet.new.latest_original_tweet_number_of_specific_screen_name(screen_name)
        default_options = {
          since_id:
        }
        options = default_options.update(options)

        target_tweet_objects = TwitterApi::SpecificUserTimeline.execute(user_id:, screen_name:,
                                                                        options:)
        target_user_objects = TwitterApi::ExchangeTweetToUser.execute(target_tweet_objects)

        # 下の2つの順番には依存性がある
        TwitterApi::UpsertObjects::UsersTable.upsert(target_user_objects)
        TwitterApi::UpsertObjects::TweetsTable.upsert(target_tweet_objects)

        TwitterApi::UpsertObjects::InUserUrisTable.upsert(target_user_objects)
        TwitterApi::UpsertObjects::HashtagsTable.upsert(target_tweet_objects)
        TwitterApi::UpsertObjects::InTweetUrisTable.upsert(target_tweet_objects)
        TwitterApi::UpsertObjects::MediaTable.upsert(target_tweet_objects)
      end

      # TODO: this is an example method
      def self.execute_for_gensosenkyo_account(options)
        execute(screen_name: 'gensosenkyo', options:)
      end
    end
  end
end
# rubocop:enable Rails/SkipsModelValidations
