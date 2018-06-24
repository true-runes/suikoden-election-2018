# == Schema Information
#
# Table name: users
#
#  id                 :bigint(8)        not null, primary key
#  screen_name        :string(255)      default(""), not null
#  name               :string(255)      default(""), not null
#  user_number        :string(255)      not null
#  description        :string(255)      default(""), not null
#  uri                :string(255)      default(""), not null
#  tweet_count        :integer          default(-1), not null
#  profile_banner_uri :string(255)      default(""), not null
#  profile_image_uri  :string(255)      default(""), not null
#  favorite           :integer          default(-1), not null
#  followers          :integer          default(-1), not null
#  followee           :integer          default(-1), not null
#  listed             :integer          default(-1), not null
#  language           :string(255)      default(""), not null
#  location           :string(255)      default(""), not null
#  website            :string(255)      default(""), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  deleted_at         :datetime
#  bg_color           :string(255)      default(""), not null
#  link_color         :string(255)      default(""), not null
#  border_color       :string(255)      default(""), not null
#  side_color         :string(255)      default(""), not null
#  text_color         :string(255)      default(""), not null
#  time_zone          :string(255)      default(""), not null
#  utc_offset         :string(255)      default(""), not null
#  account_created_at :datetime         default(Tue, 01 Jan 1980 21:00:00 JST +09:00), not null
#  connections        :string(255)      default(""), not null
#  email              :string(255)      default(""), not null
#

class User < ApplicationRecord
  acts_as_paranoid

  has_many :in_user_uris
  has_many :user_mentions
  has_many :tweets
  after_create :user_model_done

  validates :screen_name, presence: true
  validates :user_number, uniqueness: true, presence: true

  def valid_condition_for_vote
    {
      is_retweet: 0,
      tweeted_at: '2018-06-22 21:00:00'.in_time_zone('Tokyo')..'2018-06-24 09:00:00'.in_time_zone('Tokyo')
    }
  end

  def invalid_condition_for_vote
    {
      user_id: 28, # gensosenkyo
    }
  end

  def users_with_valid_vote
    User.joins(:tweets).includes(:tweets).where(tweets: valid_condition_for_vote)
  end

  def user_with_valid_votes(screen_name)
    User.joins(:tweets).includes(:tweets).where(screen_name: screen_name, tweets: valid_condition_for_vote).first
  end

  def user_with_valid_votes_count(screen_name)
    User.joins(:tweets).includes(:tweets).where(screen_name: screen_name, tweets: valid_condition_for_vote).where.not(id: 28).first.tweets.size
  end

  # TODO: メソッド名なんか違う
  def user_name_in_db(screen_name)
    User.where(screen_name: screen_name).first
  end
end
