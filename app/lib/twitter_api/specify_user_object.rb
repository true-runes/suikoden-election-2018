class TwitterApi::SpecifyUserObject
  extend TwitterApi::Client
  TAKE_TWEETS_NUMBER = 100

  def self.execute_by_one_user(twitter_user_id:)
    twitter_api_client.user(twitter_user_id.to_i)
  end
end
