# frozen_string_literal: true

class AddUniqueToEntitiesColumns < ActiveRecord::Migration[5.2]
  def change
    add_index :in_tweet_uris, %i[tweet_id uri indices], unique: true
    add_index :in_user_uris, %i[user_id uri indices], unique: true
    add_index :user_mentions, %i[tweet_id user_id indices], unique: true
  end
end
