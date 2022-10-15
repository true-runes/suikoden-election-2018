# frozen_string_literal: true

class CreateInTweetUris < ActiveRecord::Migration[5.2]
  def change
    create_table :in_tweet_uris do |t|
      t.references :tweet, foreign_key: true
      t.string :uri, null: false, default: 'UNKNOWN'

      t.timestamps
    end
  end
end
