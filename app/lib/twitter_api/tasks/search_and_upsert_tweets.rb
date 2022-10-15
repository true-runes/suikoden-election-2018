# frozen_string_literal: true

# rubocop:disable Rails/SkipsModelValidations
module TwitterApi
  module Tasks
    class SearchAndUpsertTweets
      def self.execute(search_word:)
        options = {
          since_id: TwitterApi::SearchTweet.latest_tweet_number(search_word:)
        }
        target_tweet_objects = TwitterApi::SearchTweet.search(search_word:, options:)
        target_user_objects = TwitterApi::ExchangeTweetToUser.execute(target_tweet_objects)

        TwitterApi::UpsertObjects::SearchWordsTable.upsert(search_word:)

        # 下の2つの順番には依存性がある
        TwitterApi::UpsertObjects::UsersTable.upsert(target_user_objects)
        TwitterApi::UpsertObjects::TweetsTable.upsert(target_tweet_objects, search_word:)

        TwitterApi::UpsertObjects::InUserUrisTable.upsert(target_user_objects)
        TwitterApi::UpsertObjects::HashtagsTable.upsert(target_tweet_objects)
        TwitterApi::UpsertObjects::InTweetUrisTable.upsert(target_tweet_objects)
        TwitterApi::UpsertObjects::MediaTable.upsert(target_tweet_objects)
      end

      def self.execute_with_manually(search_word:, since_id:, max_id:)
        options = {
          since_id:,
          max_id:
        }
        target_tweet_objects = TwitterApi::SearchTweet.search(search_word:, options:)
        target_user_objects = TwitterApi::ExchangeTweetToUser.execute(target_tweet_objects)

        TwitterApi::UpsertObjects::SearchWordsTable.upsert(search_word:)

        # 下の2つの順番には依存性がある
        TwitterApi::UpsertObjects::UsersTable.upsert(target_user_objects)
        TwitterApi::UpsertObjects::TweetsTable.upsert(target_tweet_objects, search_word:)

        TwitterApi::UpsertObjects::InUserUrisTable.upsert(target_user_objects)
        TwitterApi::UpsertObjects::HashtagsTable.upsert(target_tweet_objects)
        TwitterApi::UpsertObjects::InTweetUrisTable.upsert(target_tweet_objects)
        TwitterApi::UpsertObjects::MediaTable.upsert(target_tweet_objects)
      end
    end
  end
end
# rubocop:enable Rails/SkipsModelValidations
