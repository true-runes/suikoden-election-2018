class CreateTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets do |t|
      t.bigint :tweet_user_id
      t.bigint :tweet_search_word_id

      t.string :tweet_number
      t.string :body, default: '', null: false
      t.string :uri, default: 'UNKNOWN', null: false
      t.string :uri_t_co, default: 'UNKNOWN', null: false
      t.datetime :tweeted_at, default: '1980-01-01 21:00:00', null: false

      t.boolean :is_retweet, default: false, null: false
      t.integer :favorite_count, default: -1, null: false
      t.integer :retweet_count, default: -1, null: false

      t.string :client_name, default: 'UNKNOWN', null: false
      t.string :language, default: 'UNKNOWN', null: false

      t.string :in_reply_to_status_id, default: 'NO STATUS ID', null: false
      t.string :in_reply_to_user_id, default: 'NO_USER_ID', null: false
      t.string :in_reply_to_screen_name, default: 'NO SCREEN NAME', null: false

      t.boolean :has_inner_mentions, default: false, null: false
      t.boolean :has_inner_uris, default: false, null: false
      t.boolean :has_symbols, default: false, null: false
      t.boolean :has_media, default: false, null: false
      t.boolean :has_hashtags, default: false, null: false

      t.datetime :deleted_at # paranoia (null <-> Time)

      t.timestamps
    end

    add_index :tweets, :tweet_number, unique: true
    add_foreign_key :tweets, :tweet_search_words
    add_foreign_key :tweets, :tweet_users
  end
end
