# frozen_string_literal: true

# == Schema Information
#
# Table name: in_tweet_uris
#
#  id         :bigint(8)        not null, primary key
#  tweet_id   :bigint(8)
#  uri        :string(255)      default("UNKNOWN"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :in_tweet_uri do
  end
end
