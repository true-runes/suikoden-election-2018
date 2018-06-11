class AddIndexToTweets < ActiveRecord::Migration[5.2]
  def up
    add_index :tweets, :tweet_id, unique: true
  end

  def down
    remove_index :tweets, :tweet_id
  end
end
