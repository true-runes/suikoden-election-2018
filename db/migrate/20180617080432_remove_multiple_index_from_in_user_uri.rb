# frozen_string_literal: true

class RemoveMultipleIndexFromInUserUri < ActiveRecord::Migration[5.2]
  def up
    remove_index :in_user_uris, %i[user_id uri]
  end

  def down
    add_index :in_user_uris, %i[user_id uri], unique: true
  end
end
