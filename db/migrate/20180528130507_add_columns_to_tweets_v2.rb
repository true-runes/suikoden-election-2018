class AddColumnsToTweetsV2 < ActiveRecord::Migration[5.2]
  def change # up and down が望ましい
    add_column :tweets, :favorite_count, :integer, after: :user_id, null: false, default: -1
    add_column :tweets, :in_reply_to_screen_name, :string, after: :user_id, null: false, default: 'NO SCREEN NAME'
    add_column :tweets, :in_reply_to_status_id, :string, after: :user_id, null: false, default: 'NO STATUS ID'
    add_column :tweets, :in_reply_to_user_id, :string, after: :user_id, null: false, default: 'NO_USER_ID'
    add_column :tweets, :lang , :string, after: :user_id, null: false, default: 'UNKNOWN'
    add_column :tweets, :retweet_count, :integer, after: :user_id, null: false, default: -1
    add_column :tweets, :client_name, :string, after: :user_id, null: false, default: 'UNKNOWN'
    add_column :tweets, :uri, :string, after: :user_id, null: false, default: 'UNKNOWN'
    add_column :tweets, :tweeted_at, :datetime, after: :user_id, null: false, default: '1980-01-01 21:00:00'
    add_column :tweets, :is_retweet, :boolean, after: :user_id, null: false, default: false

    # テーブル分割が必要
    add_column :tweets, :has_hashtags, :boolean, after: :user_id, null: false, default: false
    add_column :tweets, :has_media, :boolean, after: :user_id, null: false, default: false
    add_column :tweets, :has_symbols, :boolean, after: :user_id, null: false, default: false
    add_column :tweets, :has_uris, :boolean, after: :user_id, null: false, default: false
    add_column :tweets, :has_user_mentions, :boolean, after: :user_id, null: false, default: false
  end
end
