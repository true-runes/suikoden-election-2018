class ApplicationController < ActionController::Base
  if Rails.env == 'development'
    USERNAME = Rails.application.credentials.digest_auth[:username].freeze
    PASSWORD = Rails.application.credentials.digest_auth[:password].freeze

    REALM = 'for developers'.freeze
    USERS = {
      USERNAME => Digest::MD5.hexdigest(
        [
          USERNAME, REALM, PASSWORD
        ].join(':')
      )
    }.freeze

    before_action :digest_authenticate

    private
    def digest_authenticate
      authenticate_or_request_with_http_digest(REALM) do |username|
        USERS[username]
      end
    end
  end
end
