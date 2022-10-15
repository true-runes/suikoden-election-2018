# frozen_string_literal: true

class CreateTweetSymbols < ActiveRecord::Migration[5.2]
  def change
    create_table :tweet_symbols do |t|
      t.bigint :tweet_id
      t.string :name, default: 'UNKNOWN', null: false

      t.timestamps
    end

    add_foreign_key :tweet_symbols, :tweets
  end
end
