# frozen_string_literal: true

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

require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
