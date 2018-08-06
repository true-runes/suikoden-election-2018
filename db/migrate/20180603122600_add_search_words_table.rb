class AddSearchWordsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :search_words do |t|
      t.string :word

      t.timestamps
    end
  end
end
