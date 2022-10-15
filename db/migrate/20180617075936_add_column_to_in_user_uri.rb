# frozen_string_literal: true

class AddColumnToInUserUri < ActiveRecord::Migration[5.2]
  def change
    add_column :in_user_uris, :expanded_uri, :string, after: :uri, null: false, default: 'UNKNOWN'
  end
end
