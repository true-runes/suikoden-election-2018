# frozen_string_literal: true

module TwitterApi
  class ExchangeTweetToUser
    def self.execute(tweet_objects)
      user_objects = tweet_objects.map(&:user)
      user_objects.uniq
    end
  end
end
