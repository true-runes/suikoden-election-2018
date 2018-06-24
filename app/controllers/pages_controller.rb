class PagesController < ApplicationController
  def home
    # @vote_number = Tweet.where(is_retweet: 0).where(tweeted_at: '2018-06-22 21:00:00'.in_time_zone('Tokyo')..'2018-06-24 09:00:00'.in_time_zone('Tokyo')).size
  end
end
