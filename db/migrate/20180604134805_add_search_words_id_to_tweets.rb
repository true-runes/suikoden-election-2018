# frozen_string_literal: true

class AddSearchWordsIdToTweets < ActiveRecord::Migration[5.2]
  def change
    add_reference :tweets, :search_words, foreign_key: true
  end
end
