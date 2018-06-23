class TwitterApi::Tasks::CheckAndUpdateTweetExistence
  extend TwitterApi::Client

  def self.execute
    all_tweet_numbers = Tweet.new.tweet_numbers_of_valid_vote_tweets
    divided_tweet_numbers = all_tweet_numbers.each_slice(100).to_a

    divided_tweet_numbers.each do |tweet_numbers|
      alive_tweet_numbers = []
      not_alive_tweet_numbers = []

      alive_tweet_objects = twitter_api_client.statuses(tweet_numbers)

      alive_tweet_numbers = alive_tweet_objects.map { |alive_tweet_object| alive_tweet_object.id }
      not_alive_tweet_numbers = tweet_numbers - alive_tweet_numbers

      # soft delete by paranoia
      not_alive_tweet_records = Tweet.where(tweet_number: not_alive_tweet_numbers)
      not_alive_tweet_records.each do |record|
        record.destroy
      end
    end
  end

  def self.debug_execute
    all_tweet_numbers = Tweet.new.tweet_numbers_of_valid_vote_tweets
    divided_tweet_numbers = all_tweet_numbers.each_slice(100).to_a # 要素は Integer

    debug_result = []
    divided_tweet_numbers.each do |tweet_numbers|
      alive_tweet_objects = twitter_api_client.statuses(tweet_numbers)

      alive_tweet_numbers = alive_tweet_objects.map { |alive_tweet_object| alive_tweet_object.id }
      not_alive_tweet_numbers = tweet_numbers - alive_tweet_numbers

      # soft delete by paranoia
      not_alive_tweet_records = Tweet.where(tweet_number: not_alive_tweet_numbers)
      debug_result << not_alive_tweet_records
    end

    debug_result
  end

  def self.execute_with_argument(all_tweet_numbers)
    divided_tweet_numbers = all_tweet_numbers.each_slice(100).to_a

    divided_tweet_numbers.each do |tweet_numbers|
      alive_tweet_objects = twitter_api_client.statuses(tweet_numbers)

      alive_tweet_numbers = alive_tweet_objects.map { |alive_tweet_object| alive_tweet_object.id }
      not_alive_tweet_numbers = tweet_numbers - alive_tweet_numbers

      # soft delete by paranoia
      not_alive_tweet_records = Tweet.where(tweet_number: not_alive_tweet_numbers)
      not_alive_tweet_records.each do |record|
        record.destroy
      end
    end
  end

  def self.alive_tweet_objects(tweet_numbers)
    twitter_api_client.statuses(tweet_numbers) # 取得できない場合は戻り値として返ってこない
  end

  def self.restore_all
    all_tweet_numbers = Tweet.new.tweet_numbers_of_valid_vote_tweets

    only_deleted_tweet_ids = Tweet.only_deleted.pluck(:id)
    Tweet.restore(only_deleted_tweet_ids)
  end
end
