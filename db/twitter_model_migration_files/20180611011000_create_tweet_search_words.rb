# frozen_string_literal: true

class CreateTweetSearchWords < ActiveRecord::Migration[5.2]
  def change
    create_table :tweet_search_words do |t|
      t.bigint :tweet_search_word_id
      t.string :word

      t.timestamps
    end

    add_index :tweet_search_words, :word, unique: true
  end
end
