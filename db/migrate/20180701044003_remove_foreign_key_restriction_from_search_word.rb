class RemoveForeignKeyRestrictionFromSearchWord < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :tweets, :search_words
  end
end
