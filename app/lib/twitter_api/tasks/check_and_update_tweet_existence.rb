class TwitterApi::Tasks::CheckAndUpdateTweetExistence
  extend TwitterApi::Client

  def self.execute
    all_tweet_numbers = Tweet.all.pluck(:tweet_number)
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
end
