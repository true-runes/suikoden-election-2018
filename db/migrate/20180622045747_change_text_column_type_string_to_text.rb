# frozen_string_literal: true

class ChangeTextColumnTypeStringToText < ActiveRecord::Migration[5.2]
  def change
    change_column :tweets, :text, :text, default: nil
  end
end
