# frozen_string_literal: true

class CreateHashtags < ActiveRecord::Migration[5.2]
  def change
    create_table :hashtags do |t|
      t.references :tweet, foreign_key: true
      t.string :name, null: false, default: 'UNKNOWN'

      t.timestamps
    end
  end
end
