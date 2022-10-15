# frozen_string_literal: true

class AddIndexToMedia < ActiveRecord::Migration[5.2]
  def change
    add_index :media, :medium_own_id
  end
end
