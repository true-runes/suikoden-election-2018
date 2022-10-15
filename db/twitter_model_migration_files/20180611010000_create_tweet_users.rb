# frozen_string_literal: true

class CreateTweetUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :tweet_users do |t|
      t.bigint :tweet_user_id

      t.string :user_number, null: false # bigintでも大丈夫っぽいが、将来的なことも考えると安全な方で
      t.string :screen_name, default: '', null: false
      t.string :name, default: '', null: false
      t.string :description, default: '', null: false
      t.string :uri, default: '', null: false

      # TODO: 要確認
      t.string :tturi_t_co, default: '', null: false

      t.integer :tweet_count, default: -1, null: false

      t.integer :favorite, default: -1, null: false
      t.integer :followers, default: -1, null: false
      t.integer :followee, default: -1, null: false
      t.integer :listed, default: -1, null: false

      t.string :language, default: '', null: false
      t.string :location, default: '', null: false
      t.string :website, default: '', null: false

      # TODO: 複数の画像サイズのアドレスがあるため、ベースとなる URI をここには記録する
      t.string :profile_banner_base_uri, default: '', null: false
      t.string :profile_image_base_uri, default: '', null: false

      t.string :bg_color, default: '', null: false
      t.string :border_color, default: '', null: false
      t.string :side_color, default: '', null: false

      t.string :text_color, default: '', null: false
      t.string :link_color, default: '', null: false # なんのlink？

      t.string :time_zone, default: '', null: false
      t.string :utc_offset, default: '', null: false

      t.string :connections, default: '', null: false # なにこれ

      t.string :email, default: '', null: false

      t.boolean :is_protected, default: false, null: false
      t.boolean :blocks_me, default: false, null: false

      t.datetime :deleted_at
      t.datetime :account_created_at, default: '1980-01-01 12:00:00', null: false

      t.timestamps
    end

    add_index :tweet_users, :user_number, unique: true
  end
end
