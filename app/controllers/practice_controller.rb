# frozen_string_literal: true

require 'digest/md5'

class PracticeController < ApplicationController
  def index
    @tweets = Tweet.valid_vote_tweets_with_order_by(order_by: :asc).page params[:page]
  end
end
