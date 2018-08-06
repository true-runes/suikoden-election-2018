class AddMediaIdToMedia < ActiveRecord::Migration[5.2]
  def change
    add_column :media, :medium_own_id, :string, after: :tweet_id, null: false, default: 'UNKNOWN'
  end
end
