class VotesController < ApplicationController
  def index
    @tweets = Tweet.valid_vote_tweets_with_order_by(order_by: :desc).page params[:page]
  end
end
