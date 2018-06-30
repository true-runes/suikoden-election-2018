class PagesController < ApplicationController
  def now_counting
    @all_tweets_count = Tweet.now_counting_tweets.size
    @tweets = Tweet.now_counting_tweets.page params[:page]
  end

  def home
    # @vote_number = Tweet.where(is_retweet: 0).where(tweeted_at: '2018-06-22 21:00:00'.in_time_zone('Tokyo')..'2018-06-24 09:00:00'.in_time_zone('Tokyo')).size
  end
end
