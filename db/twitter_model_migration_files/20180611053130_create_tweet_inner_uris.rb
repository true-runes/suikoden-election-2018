class CreateTweetInnerUris < ActiveRecord::Migration[5.2]
  def change
    create_table :tweet_inner_uris do |t|
      t.bigint :tweet_id
      t.string :uri, default: 'UNKNOWN', null: false
      t.string :uri_t_co, default: 'UNKNOWN', null: false

      t.timestamps
    end

    add_foreign_key :tweet_inner_uris, :tweets
  end
end
