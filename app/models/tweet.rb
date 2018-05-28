class Tweet < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
  has_many :hashtags
end
