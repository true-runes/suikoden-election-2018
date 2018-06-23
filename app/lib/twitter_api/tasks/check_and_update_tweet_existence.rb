class TwitterApi::Tasks::CheckAndUpdateTweetExistence
  extend TwitterApi::Client

  def self.execute
    all_tweet_numbers = Tweet.new.tweet_numbers_of_valid_vote_tweets
    divided_tweet_numbers = all_tweet_numbers.each_slice(100).to_a

    # HACK: NOT DRY...?
    divided_tweet_numbers.each do |tweet_numbers|
      tweet_objects = twitter_api_client.statuses(tweet_numbers)
      user_objects = TwitterApi::ExchangeTweetToUser.execute(tweet_objects);

      # 下の2つの順番には依存性がある
      TwitterApi::UpsertObjects::UsersTable.upsert(user_objects)
      TwitterApi::UpsertObjects::TweetsTable.upsert(tweet_objects)

      TwitterApi::UpsertObjects::InUserUrisTable.upsert(user_objects)
      TwitterApi::UpsertObjects::HashtagsTable.upsert(tweet_objects)
      TwitterApi::UpsertObjects::InTweetUrisTable.upsert(tweet_objects)
      TwitterApi::UpsertObjects::MediaTable.upsert(tweet_objects)
    end
  end

  def self.debug_execute
    all_tweet_numbers = Tweet.new.tweet_numbers_of_valid_vote_tweets
    divided_tweet_numbers = all_tweet_numbers.each_slice(100).to_a

    divided_tweet_numbers.each do |tweet_numbers|
      alive_tweet_objects = twitter_api_client.statuses(tweet_numbers)

      alive_tweet_numbers = alive_tweet_objects.map { |alive_tweet_object| alive_tweet_object.id }
      not_alive_tweet_numbers = all_tweet_numbers - alive_tweet_numbers

      # soft delete by paranoia
      not_alive_tweet_records = Tweet.where(tweet_number: not_alive_tweet_numbers)
      not_alive_tweet_records.each do |record|
        record.destroy
      end
    end
  end

  def self.debug_each_tweet_execute(all_tweet_numbers)
    # all_tweet_numbers = [1010167033432948737]
    divided_tweet_numbers = all_tweet_numbers.each_slice(100).to_a

    divided_tweet_numbers.each do |tweet_numbers|
      alive_tweet_objects = twitter_api_client.statuses(tweet_numbers)

      alive_tweet_numbers = alive_tweet_objects.map { |alive_tweet_object| alive_tweet_object.id }
      not_alive_tweet_numbers = all_tweet_numbers - alive_tweet_numbers

      # soft delete by paranoia
      not_alive_tweet_records = Tweet.where(tweet_number: not_alive_tweet_numbers)
      not_alive_tweet_records.each do |record|
        record.destroy
      end
    end
  end
end
