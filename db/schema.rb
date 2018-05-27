# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_05_27_124321) do

  create_table "tweets", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "tweet_number"
    t.bigint "user_id"
    t.string "text", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_tweets_on_deleted_at"
    t.index ["tweet_number"], name: "index_tweets_on_tweet_number", unique: true
    t.index ["user_id"], name: "index_tweets_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "screen_name", default: "", null: false
    t.string "name", default: "", null: false
    t.string "user_number", null: false
    t.string "description", default: "", null: false
    t.string "uri", default: "", null: false
    t.integer "tweet_count", default: -1, null: false
    t.string "profile_banner_uri", default: "", null: false
    t.string "profile_image_uri", default: "", null: false
    t.integer "favorite", default: -1, null: false
    t.integer "followers", default: -1, null: false
    t.integer "followee", default: -1, null: false
    t.integer "listed", default: -1, null: false
    t.string "language", default: "", null: false
    t.string "location", default: "", null: false
    t.string "website", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.string "bg_color", default: "", null: false
    t.string "link_color", default: "", null: false
    t.string "border_color", default: "", null: false
    t.string "side_color", default: "", null: false
    t.string "text_color", default: "", null: false
    t.string "time_zone", default: "", null: false
    t.string "utc_offset", default: "", null: false
    t.datetime "account_created_at", default: "1980-01-01 21:00:00", null: false
    t.string "connections", default: "", null: false
    t.string "email", default: "", null: false
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["user_number"], name: "index_users_on_user_number", unique: true
  end

  add_foreign_key "tweets", "users"
end
