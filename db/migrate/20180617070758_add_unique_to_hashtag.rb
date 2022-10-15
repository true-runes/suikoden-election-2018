# frozen_string_literal: true

class AddUniqueToHashtag < ActiveRecord::Migration[5.2]
  def change
    add_index :hashtags, %i[tweet_id name indices], unique: true
  end
end
