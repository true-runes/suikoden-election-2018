class TwitterApi::ExcangeTweetToUser
  def self.execute(tweet_objects)
    tweet_objects.map { |tweet_object| tweet_object.user }
  end
end
