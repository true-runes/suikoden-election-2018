# == Schema Information
#
# Table name: media
#
#  id         :bigint(8)        not null, primary key
#  tweet_id   :bigint(8)
#  uri        :string(255)      default("UNKNOWN"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :medium do
    
  end
end
