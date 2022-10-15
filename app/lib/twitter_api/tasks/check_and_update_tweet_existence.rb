# frozen_string_literal: true

module TwitterApi
  module Tasks
    class CheckAndUpdateTweetExistence
      extend TwitterApi::Client

      def self.execute
        all_tweet_numbers = Tweet.new.tweet_numbers_of_valid_vote_tweets
        divided_tweet_numbers = all_tweet_numbers.each_slice(100).to_a

        divided_tweet_numbers.each do |tweet_numbers|
          alive_tweet_objects = twitter_api_client.statuses(tweet_numbers)

          alive_tweet_numbers = alive_tweet_objects.map(&:id)
          not_alive_tweet_numbers = tweet_numbers - alive_tweet_numbers

          # soft delete by paranoia
          not_alive_tweet_records = Tweet.where(tweet_number: not_alive_tweet_numbers)
          not_alive_tweet_records.each(&:destroy)
        end
      end

      def self.execute_with_argument(all_tweet_numbers)
        divided_tweet_numbers = all_tweet_numbers.each_slice(100).to_a

        divided_tweet_numbers.each do |tweet_numbers|
          alive_tweet_objects = twitter_api_client.statuses(tweet_numbers)

          alive_tweet_numbers = alive_tweet_objects.map(&:id)
          not_alive_tweet_numbers = tweet_numbers - alive_tweet_numbers

          # soft delete by paranoia
          not_alive_tweet_records = Tweet.where(tweet_number: not_alive_tweet_numbers)
          not_alive_tweet_records.each(&:destroy)
        end
      end

      def self.restore_all
        all_tweet_numbers = Tweet.new.tweet_numbers_of_valid_vote_tweets # rubocop:disable Lint/UselessAssignment

        only_deleted_tweet_ids = Tweet.only_deleted.pluck(:id)
        Tweet.restore(only_deleted_tweet_ids)
      end
    end
  end
end
