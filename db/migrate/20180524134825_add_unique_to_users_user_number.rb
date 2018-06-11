class AddUniqueToUsersUserNumber < ActiveRecord::Migration[5.2]
  def change
    add_index :users, :user_number, unique: true
  end
end
