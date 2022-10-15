# frozen_string_literal: true

class CreateInUserUris < ActiveRecord::Migration[5.2]
  def change
    create_table :in_user_uris do |t|
      t.references :user, foreign_key: true
      t.string :uri, null: false, default: 'UNKNOWN'

      t.timestamps
    end
  end
end
