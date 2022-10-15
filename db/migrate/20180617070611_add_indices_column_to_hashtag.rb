# frozen_string_literal: true

class AddIndicesColumnToHashtag < ActiveRecord::Migration[5.2]
  def change
    add_column :hashtags, :indices, :string, after: :name, null: false, default: 'UNKNOWN'
  end
end
