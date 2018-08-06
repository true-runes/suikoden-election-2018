class AddManyColumnsToUsers < ActiveRecord::Migration[5.2]
  def up
    add_column :users, :name, :string, after: :screen_name, null: false, default: ''
    add_column :users, :description, :string, after: :user_number, null: false, default: ''
    add_column :users, :uri, :string, after: :description, null: false, default: ''
    add_column :users, :tweet_count, :integer, after: :uri, null: false, default: -1

    add_column :users, :profile_banner_uri, :string, after: :tweet_count, null: false, default: ''
    add_column :users, :profile_image_uri, :string, after: :profile_banner_uri, null: false, default: ''

    add_column :users, :favorite, :integer, after: :profile_image_uri, null: false, default: -1
    add_column :users, :followers, :integer, after: :favorite, null: false, default: -1
    add_column :users, :followee, :integer, after: :followers, null: false, default: -1
    add_column :users, :listed, :integer, after: :followee, null: false, default: -1

    add_column :users, :language, :string, after: :listed, null: false, default: ''
    add_column :users, :location, :string, after: :language, null: false, default: ''

    add_column :users, :website, :string, after: :location, null: false, default: ''

    # before: :foobar は強制的に after: になってそう
    add_column :users, :bg_color, :string, before: :created_at, null: false, default: ''
    add_column :users, :link_color, :string, before: :created_at, null: false, default: ''
    add_column :users, :border_color, :string, before: :created_at, null: false, default: ''
    add_column :users, :side_color, :string, before: :created_at, null: false, default: ''
    add_column :users, :text_color, :string, before: :created_at, null: false, default: ''

    add_column :users, :time_zone, :string, before: :created_at, null: false, default: ''
    add_column :users, :utc_offset, :string, before: :created_at, null: false, default: ''
    add_column :users, :account_created_at, :datetime, before: :created_at, null: false, default: '1980-01-01 12:00:00 UTC'

    add_column :users, :connections, :string, before: :created_at, null: false, default: ''
    add_column :users, :email, :string, before: :created_at, null: false, default: ''
  end

  def down
    remove_column :users, :name, :string, after: :screen_name, null: false, default: ''
    remove_column :users, :description, :text, after: :name, null: false, default: ''
    remove_column :users, :uri, :string, after: :description, null: false, default: ''
    remove_column :users, :tweet_count, :integer, after: :uri, null: false, default: ''

    remove_column :users, :profile_banner_uri, :string, after: :tweet_count, null: false, default: ''
    remove_column :users, :profile_image_uri, :string, after: :profile_image_uri, null: false, default: ''

    remove_column :users, :favorite, :integer, after: :profile_image_uri, null: false, default: -1
    remove_column :users, :followers, :integer, after: :favorite, null: false, default: -1
    remove_column :users, :followee, :integer, after: :followers, null: false, default: -1
    remove_column :users, :listed, :integer, after: :followee, null: false, default: -1

    remove_column :users, :language, :string, after: :listed, null: false, default: ''
    remove_column :users, :location, :string, after: :language, null: false, default: ''

    remove_column :users, :website, :string, after: :location, null: false, default: ''

    remove_column :users, :bg_color, :string, before: :created_at, null: false, default: ''
    remove_column :users, :link_color, :string, before: :created_at, null: false, default: ''
    remove_column :users, :border_color, :string, before: :created_at, null: false, default: ''
    remove_column :users, :side_color, :string, before: :created_at, null: false, default: ''
    remove_column :users, :text_color, :string, before: :created_at, null: false, default: ''

    remove_column :users, :time_zone, :string, before: :created_at, null: false, default: ''
    remove_column :users, :utc_offset, :string, before: :created_at, null: false, default: ''
    remove_column :users, :account_created_at, :datetime, before: :created_at, null: false, default: '1980-01-01 12:00:00 UTC'

    remove_column :users, :connections, :string, before: :created_at, null: false, default: ''
    remove_column :users, :email, :string, before: :created_at, null: false, default: ''
  end
end
