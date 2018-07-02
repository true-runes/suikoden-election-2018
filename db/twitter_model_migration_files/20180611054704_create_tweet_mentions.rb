class CreateTweetMentions < ActiveRecord::Migration[5.2]
  def change
    create_table :tweet_mentions do |t|
      t.bigint :tweet_id
      t.string :name, default: 'UNKNOWN', null: false

      t.timestamps
    end

    add_foreign_key :tweet_mentions, :tweets
  end
end
