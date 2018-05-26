module CollectTweetHelper
  # TODO: Decoratorに統一する（名前衝突の危険があるため）
  def suikoden
    "幻水総選挙"
  end

  def client
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.credentials.twitter_api[:consumer_key]
      config.consumer_secret     = Rails.application.credentials.twitter_api[:consumer_secret]
      config.access_token        = Rails.application.credentials.twitter_api[:access_token]
      config.access_token_secret = Rails.application.credentials.twitter_api[:access_token_secret]
    end
  end

  def tweets_by_hashtag
    client
    @client.search('幻水', { tweet_mode: "extended" }).take(20)
  end
end
