class RenameColumnNameOnTweets < ActiveRecord::Migration[5.2]
  def up
    rename_column :tweets, :tweet_id, :tweet_number
  end

  def down
    rename_column :tweets, :tweet_number, :tweet_id
  end
end
