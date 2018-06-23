class CheckVoteController < ApplicationController
  def index
    if params[:screen_name]
      @screen_name = params[:screen_name]

      if User.joins(:tweets).includes(:tweets).where(screen_name: @screen_name, tweets: { is_retweet: 0 }).first.nil?
        @target_tweets = []
      else
        @target_tweets = User.joins(:tweets).includes(:tweets).where(screen_name: @screen_name, tweets: { is_retweet: 0 }).first.tweets
      end

      # if User.joins(:tweets).includes(:tweets).where(screen_name: @screen_name, tweets: { is_retweet: 0, tweeted_at: '2018-06-22 21:00:00'.in_time_zone('Tokyo')..'2018-06-24 09:00:00'.in_time_zone('Tokyo') }).first.nil?
      #   @target_tweets = []
      # else
      #   @target_tweets = User.joins(:tweets).includes(:tweets).where(screen_name: @screen_name, tweets: { is_retweet: 0, tweeted_at: '2018-06-22 21:00:00'.in_time_zone('Tokyo')..'2018-06-24 09:00:00'.in_time_zone('Tokyo') }).first.tweets
      # end

      @vote_number = @target_tweets.size

      if User.where(screen_name: @screen_name).first.nil?
        @user_name = nil
      else
        @user_name = User.where(screen_name: @screen_name).first.name
        @profile_image_uri = User.where(screen_name: @screen_name).first.profile_image_uri
      end
    end
  end

  def create
  end
end