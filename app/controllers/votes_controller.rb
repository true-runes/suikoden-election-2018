class VotesController < ApplicationController
  def index
    # TODO: モデルに入れる
    is_retweet_validation = {
      is_retweet: 0,
    }
    tweeted_at_validation = {
      # tweeted_at: '2018-06-22 21:00:00'.in_time_zone('Tokyo')..'2018-06-24 09:59:59'.in_time_zone('Tokyo'),
    }
    user_id_validation = {
      user_id: 28,
    }

    tweets_ascending = Tweet.without_deleted.where(is_retweet_validation).where(tweeted_at_validation).where.not(user_id_validation).order(tweeted_at: :asc)

    @tweets = tweets_ascending.page params[:page]
  end
end
