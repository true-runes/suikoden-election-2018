class AddUniqueToInUserUri < ActiveRecord::Migration[5.2]
  def change
    # add_index :in_user_uris, [:user_id, :uri, :indices], unique: true
  end
end
