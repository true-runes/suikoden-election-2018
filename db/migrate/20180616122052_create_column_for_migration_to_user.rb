class CreateColumnForMigrationToUser < ActiveRecord::Migration[5.2]
  def change
    add_reference :user_mentions, :user, foreign_key: true, after: :tweet_id
  end
end
