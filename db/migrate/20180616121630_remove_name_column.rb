class RemoveNameColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :user_mentions, :name, :string
  end
end
