# frozen_string_literal: true

class AddUniqueToInTweetUri < ActiveRecord::Migration[5.2]
  def up
    # add_index :in_tweet_uris, [:tweet_id, :uri, :indices], unique: true
  end

  def down
    # remove_index :in_tweet_uris, [:tweet_id, :uri, :indices]
  end
end
