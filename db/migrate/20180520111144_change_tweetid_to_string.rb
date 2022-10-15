# frozen_string_literal: true

class ChangeTweetidToString < ActiveRecord::Migration[5.2]
  def up
    change_column :tweets, :tweet_id, :string
  end

  def down
    change_column :tweets, :tweet_id, :integer
  end
end
