# frozen_string_literal: true

class AddMultiIndexToInUserUri < ActiveRecord::Migration[5.2]
  def change
    # DELETE & INSERT が前提だから実質的にはあまり意味はない
    add_index :in_user_uris, %i[user_id uri], unique: true
  end
end
