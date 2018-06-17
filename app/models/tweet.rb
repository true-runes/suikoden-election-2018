class Tweet < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
  belongs_to :search_word

  has_many :user_mentions
  has_many :in_tweet_uris
  has_many :media
  has_many :hashtags
end
