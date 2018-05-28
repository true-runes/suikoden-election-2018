# == Schema Information
#
# Table name: user_mentions
#
#  id         :bigint(8)        not null, primary key
#  tweet_id   :bigint(8)
#  name       :string(255)      default("UNKNOWN"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :user_mention do
    
  end
end
