# frozen_string_literal: true

module TwitterApi
  class SpecificUserObject
    extend TwitterApi::Client

    def self.execute_by_one_user(user_id:)
      user_id = user_id.to_i
      twitter_api_client.user(user_id)
    end
  end
end
