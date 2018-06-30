class TwitterApi::SpecifyUserObject
  extend TwitterApi::Client

  def self.execute_by_one_user(twitter_user_id:)
    twitter_user_id = twitter_user_id.to_i
    twitter_api_client.user(twitter_user_id)
  end
end
