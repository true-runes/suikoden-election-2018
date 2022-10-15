# frozen_string_literal: true

class AddReferenceToUsers < ActiveRecord::Migration[5.2]
  def change
    # null: false を指定するとエラーになる
    add_reference :tweets, :user, index: true, after: :tweet_number, foreign_key: true
  end
end
