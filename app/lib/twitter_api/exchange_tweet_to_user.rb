class TwitterApi::ExchangeTweetToUser
  def self.execute(tweet_objects)
    user_objects = tweet_objects.map { |tweet_object| tweet_object.user }
    user_objects.uniq
  end
end
