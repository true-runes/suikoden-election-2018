# frozen_string_literal: true

class AddUniqueToSearchWords < ActiveRecord::Migration[5.2]
  def change
    add_index :search_words, :word, unique: true
  end
end
