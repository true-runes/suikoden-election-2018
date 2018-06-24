class Tweet < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
  belongs_to :search_word

  has_many :user_mentions
  has_many :in_tweet_uris
  has_many :media
  has_many :hashtags

  def validation_for_vote
    {
      is_retweet: 0,
      tweeted_at: '2018-06-22 21:00:00'.in_time_zone('Tokyo')..'2018-06-24 09:00:00'.in_time_zone('Tokyo')
    }
  end

  def not_validation_for_vote
    {
      id: 28, # gensosenkyo
    }
  end

  # こっちじゃなくて User に書く？
  def valid_users_with_tweets
    User.joins(:tweets).includes(:tweets).where(tweets: validation_for_vote).without_deleted.where.not(not_validation_for_vote).order(tweeted_at: :desc)
  end

  def valid_vote_tweets
    Tweet.where(is_retweet: 0).where(tweeted_at: '2018-06-22 21:00:00'.in_time_zone('Tokyo')..'2018-06-24 09:00:00'.in_time_zone('Tokyo'))
  end

  def debug_valid_vote_tweets
    Tweet.where(is_retweet: 0).where(tweeted_at: '2018-06-22 21:00:00'.in_time_zone('Tokyo')..'2018-06-24 09:00:00'.in_time_zone('Tokyo')).where.not(user_id: 28)
  end

  def tweet_numbers_of_valid_vote_tweets
     # TODO: to_i は全てのロジックで共通にしたほうがいい（か、DBの型をIntegerにするか？）
    valid_vote_tweets.map { |tweet| tweet.tweet_number.to_i }
  end

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
