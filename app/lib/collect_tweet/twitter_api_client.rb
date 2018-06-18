module CollectTweet::TwitterApiClient
  def twitter_api_client
    Twitter::REST::Client.new do |config|
      # 幻想水滸伝ってゲームが狂気的に面白いらしいよ？ (tmy_development)
      config.consumer_key        = Rails.application.credentials.twitter_api[:consumer_key]
      config.consumer_secret     = Rails.application.credentials.twitter_api[:consumer_secret]
      config.access_token        = Rails.application.credentials.twitter_api[:access_token]
      config.access_token_secret = Rails.application.credentials.twitter_api[:access_token_secret]
    end
  end
end
