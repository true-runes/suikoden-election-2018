class Tweet < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
  belongs_to :search_word

  has_many :user_mentions
  has_many :in_tweet_uris
  has_many :media
  has_many :hashtags

  is_retweet_validation = {
    is_retweet: 0,
  }

  tweeted_at_validation = {
    tweeted_at: '2018-06-22 21:00:00'.in_time_zone('Tokyo')..'2018-06-24 09:59:59'.in_time_zone('Tokyo'),
  }

  user_id_validation = {
    user_id: 28, # @gensosenkyo
  }

  scope :valid_vote_tweets_with_order_by, ->(order_by: nil) { Tweet.without_deleted.where(is_retweet_validation).where(tweeted_at_validation).where.not(user_id_validation).order(tweeted_at: order_by) }

  def tweet_numbers_of_valid_vote_tweets
    # TODO: to_i は全てのロジックで共通にしたほうがいい（か、DBの型をIntegerにするか？）
   Tweet.valid_vote_tweets_with_order_by.map { |tweet| tweet.tweet_number.to_i }
  end

  # def validation_for_vote
  #   {
  #     is_retweet: 0,
  #     tweeted_at: '2018-06-22 21:00:00'.in_time_zone('Tokyo')..'2018-06-24 09:59:59'.in_time_zone('Tokyo')
  #   }
  # end

  # def not_validation_for_vote
  #   {
  #     id: 28, # gensosenkyo
  #   }
  # end

  # こっちじゃなくて User に書く？
  # def valid_users_with_tweets
  #   User.joins(:tweets).includes(:tweets).where(tweets: validation_for_vote).without_deleted.where.not(not_validation_for_vote).order(tweeted_at: :desc)
  # end

  # def valid_vote_tweets
  #   Tweet.where(is_retweet: 0).where(tweeted_at: '2018-06-22 21:00:00'.in_time_zone('Tokyo')..'2018-06-24 09:59:59'.in_time_zone('Tokyo'))
  # end

  # tweets_ascending = Tweet.without_deleted.where(is_retweet_validation).where(tweeted_at_validation).where.not(user_id_validation).order(tweeted_at: :asc)

  # @tweets = tweets_ascending.page params[:page]


  # ↑からさらに @gensosenkyo を除いたものが、最終的なツイート投票になる（そこから先の無効票除外もあるが）
  # user_id_validation = {
  #   user_id: 28,
  # }
  # tweets_ascending = Tweet.without_deleted.where(is_retweet_validation).where(tweeted_at_validation).where.not(user_id_validation).order(tweeted_at: :asc)

  # TODO: 期待通りの動作でないようだ
  def check_duplicate_vote_users
    users_with_valid_vote = User.new.users_with_valid_vote

    @duplicate_vote_users = []
    users_with_valid_vote.each do |user|
      if User.new.user_with_valid_votes_count(user) >= 2
        @duplicate_vote_users << user
      end
    end

    @duplicate_vote_users
  end
end
