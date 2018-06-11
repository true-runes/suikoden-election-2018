# == Schema Information
#
# Table name: tweets
#
#  id                      :bigint(8)        not null, primary key
#  tweet_number            :string(255)
#  user_id                 :bigint(8)
#  has_user_mentions       :boolean          default(FALSE), not null
#  has_uris                :boolean          default(FALSE), not null
#  has_symbols             :boolean          default(FALSE), not null
#  has_media               :boolean          default(FALSE), not null
#  has_hashtags            :boolean          default(FALSE), not null
#  is_retweet              :boolean          default(FALSE), not null
#  tweeted_at              :datetime         default(Tue, 01 Jan 1980 21:00:00 JST +09:00), not null
#  uri                     :string(255)      default("UNKNOWN"), not null
#  client_name             :string(255)      default("UNKNOWN"), not null
#  retweet_count           :integer          default(-1), not null
#  lang                    :string(255)      default("UNKNOWN"), not null
#  in_reply_to_user_id     :string(255)      default("NO_USER_ID"), not null
#  in_reply_to_status_id   :string(255)      default("NO STATUS ID"), not null
#  in_reply_to_screen_name :string(255)      default("NO SCREEN NAME"), not null
#  favorite_count          :integer          default(-1), not null
#  text                    :string(255)      default(""), not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  deleted_at              :datetime
#

FactoryBot.define do
  factory :tweet do
    tweet_id 1
    user_id 1
  end
end
