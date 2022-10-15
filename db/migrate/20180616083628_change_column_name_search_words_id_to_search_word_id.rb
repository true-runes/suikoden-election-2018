# frozen_string_literal: true

class ChangeColumnNameSearchWordsIdToSearchWordId < ActiveRecord::Migration[5.2]
  def change
    rename_column :tweets, :search_words_id, :search_word_id
  end
end
