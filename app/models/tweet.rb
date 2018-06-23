class Tweet < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
  belongs_to :search_word

  has_many :user_mentions
  has_many :in_tweet_uris
  has_many :media
  has_many :hashtags

  def valid_vote_tweets
    Tweet.where(is_retweet: 0).where(tweeted_at: '2018-06-22 21:00:00'.in_time_zone('Tokyo')..'2018-06-24 09:00:00'.in_time_zone('Tokyo'))
  end
end
