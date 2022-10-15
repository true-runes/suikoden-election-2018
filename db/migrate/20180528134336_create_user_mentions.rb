# frozen_string_literal: true

class CreateUserMentions < ActiveRecord::Migration[5.2]
  def change
    # 命名がイケてない
    create_table :user_mentions do |t|
      t.references :tweet, foreign_key: true
      t.string :name, null: false, default: 'UNKNOWN'

      t.timestamps
    end
  end
end
