class AddUniqueToMedia < ActiveRecord::Migration[5.2]
  def change
    add_index :media, [:tweet_id, :medium_own_id], unique: true
  end
end
