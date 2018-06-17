class AddUniqueToEntitiesColumns < ActiveRecord::Migration[5.2]
  def change
    add_index :in_tweet_uris, [:tweet_id, :uri, :indices], unique: true
    add_index :in_user_uris, [:user_id, :uri, :indices], unique: true
    add_index :user_mentions, [:tweet_id, :user_id, :indices], unique: true
  end
end
