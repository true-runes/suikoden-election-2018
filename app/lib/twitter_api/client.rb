# frozen_string_literal: true

module TwitterApi
  module Client
    # 幻想水滸伝ってゲームが狂気的に面白いらしいよ？
    def twitter_api_client # rubocop:disable Metrics/AbcSize
      Twitter::REST::Client.new do |config|
        config.consumer_key        = Rails.application.credentials.twitter_api[:consumer_key]
        config.consumer_secret     = Rails.application.credentials.twitter_api[:consumer_secret]
        config.access_token        = Rails.application.credentials.twitter_api[:access_token]
        config.access_token_secret = Rails.application.credentials.twitter_api[:access_token_secret]
      end
    end
  end
end
