# frozen_string_literal: true

class RemoveTCoColumnFromTweet < ActiveRecord::Migration[5.2]
  def change
    remove_column :tweets, :uri_t_co, :string
  end
end
