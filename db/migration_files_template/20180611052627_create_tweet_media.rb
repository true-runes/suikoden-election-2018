class CreateTweetMedia < ActiveRecord::Migration[5.2]
  def change
    create_table :tweet_media do |t|
      t.bigint :tweet_id
      t.string :uri, default: 'UNKNOWN', null: false
      t.string :uri_t_co, default: 'UNKNOWN', null: false

      t.timestamps
    end

    add_foreign_key "tweet_media", "tweets"
  end
end
