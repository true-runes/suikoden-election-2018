class AddColumnsToTweets < ActiveRecord::Migration[5.2]
  def up
    # add_column :tweets, :text, :string, after: :user_id, null: false, default: ''
    add_column :tweets, :text, :string, null: false, default: ''
  end

  def down
    remove_column :tweets, :text, :string
  end
end
