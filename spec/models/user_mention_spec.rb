# frozen_string_literal: true

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

require 'rails_helper'

RSpec.describe UserMention, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
