class TwitterApi::SpecificUserTimeline
  extend TwitterApi::Client

  def self.execute(user_id: nil, screen_name: nil, options: {})
    user_identity = user_id.nil? ? screen_name : user_id.to_i

    default_options = {
      tweet_mode: 'extended',
      count: 200,
    }
    options = default_options.update(options)

    twitter_api_client.user_timeline(user_identity, options)
  end
end
