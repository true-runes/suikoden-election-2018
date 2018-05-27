module Collection
  extend ActiveSupport::Concern

  included do
    # true
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
    @client.search('#幻水総選挙運動', { tweet_mode: "extended" }).take(200)
  end

  # debug
  def all_user_numbers_in_db
    users = User.all
    users.map { |user| user.user_number }
  end

  # TODO: danger method
  # #=> Twitter::Error::Forbidden in HelloController#debug
  # #=> User has been suspended.
  # def all_user_objects_in_db
  #   # TODO: Rate Limits...???
  #   all_user_numbers_in_db.map { |user_number_in_db| user_object(user_number_in_db)}
  # end

  # *** Twitter::Error::NotFound Exception: User not found.
  #
  # nil

  # Twitter::Error::Forbidden in HelloController#debug
  # User has been suspended.
  def user_object(user_id = 126618179)
    # begin
      @client.user(user_id.to_i)
    # rescue => e
    #   e
      # do something...
    # end
  end
end