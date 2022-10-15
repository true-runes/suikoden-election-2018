# frozen_string_literal: true

class CreateTweetHashtags < ActiveRecord::Migration[5.2]
  def change
    create_table :tweet_hashtags do |t|
      t.bigint :tweet_id
      t.string :name, default: 'UNKNOWN', null: false

      t.timestamps
    end

    add_foreign_key :tweet_hashtags, :tweets
  end
end
