# frozen_string_literal: true

class AddUniqueToMedia < ActiveRecord::Migration[5.2]
  def change
    add_index :media, %i[tweet_id medium_own_id], unique: true
  end
end
