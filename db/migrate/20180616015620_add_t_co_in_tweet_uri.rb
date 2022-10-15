# frozen_string_literal: true

class AddTCoInTweetUri < ActiveRecord::Migration[5.2]
  def change
    add_column :in_tweet_uris, :uri_t_co, :string, after: :uri, null: false, default: 'UNKNOWN'
  end
end
