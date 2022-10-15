# frozen_string_literal: true

class AddEntitiesColumnsToIndices < ActiveRecord::Migration[5.2]
  def change
    add_column :in_tweet_uris, :indices, :string, after: :uri, null: false, default: 'UNKNOWN'
    add_column :in_user_uris, :indices, :string, after: :uri, null: false, default: 'UNKNOWN'
    add_column :user_mentions, :indices, :string, after: :user_id, null: false, default: 'UNKNOWN'
  end
end
