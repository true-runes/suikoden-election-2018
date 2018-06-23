class CheckVoteController < ApplicationController
  def index
    if params[:screen_name]
      @screen_name = params[:screen_name]
      user_object = User.new
      user_with_valid_votes = user_object.user_with_valid_votes(@screen_name)

      if user_with_valid_votes.nil?
        @target_tweets = []
      else
        @target_tweets = user_with_valid_votes.tweets
      end
      @vote_number = @target_tweets.size

      user_name_in_db = user_object.user_name_in_db(@screen_name)
      if user_name_in_db.nil?
        @user_name = nil
        @bigger_profile_image_uri = default_bigger_profile_image_uri
      else
        @user_name = user_name_in_db.name
        @bigger_profile_image_uri = bigger_profile_image_uri(user_name_in_db.profile_image_uri)
      end
    end
  end

  private
  def bigger_profile_image_uri(profile_image_uri)
    profile_image_uri.gsub(/_400x400\./, '_bigger.')
  end

  def default_bigger_profile_image_uri
    'https://abs.twimg.com/sticky/default_profile_images/default_profile_bigger.png'
  end
end