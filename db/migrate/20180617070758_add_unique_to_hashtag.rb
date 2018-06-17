class AddUniqueToHashtag < ActiveRecord::Migration[5.2]
  def change
    add_index :hashtags, [:tweet_id, :name, :indices], unique: true
  end
end
