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

ActiveRecord::Schema.define(version: 2018_07_03_145210) do

  create_table "hashtags", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "tweet_id"
    t.string "name", default: "UNKNOWN", null: false
    t.string "indices", default: "UNKNOWN", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tweet_id", "name", "indices"], name: "index_hashtags_on_tweet_id_and_name_and_indices", unique: true
    t.index ["tweet_id"], name: "index_hashtags_on_tweet_id"
  end

  create_table "in_tweet_uris", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "tweet_id"
    t.string "uri", default: "UNKNOWN", null: false
    t.string "indices", default: "UNKNOWN", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tweet_id", "uri", "indices"], name: "index_in_tweet_uris_on_tweet_id_and_uri_and_indices", unique: true
    t.index ["tweet_id"], name: "index_in_tweet_uris_on_tweet_id"
  end

  create_table "in_user_uris", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "user_id"
    t.string "uri", default: "UNKNOWN", null: false
    t.string "expanded_uri", default: "UNKNOWN", null: false
    t.string "indices", default: "UNKNOWN", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "uri", "indices"], name: "index_in_user_uris_on_user_id_and_uri_and_indices", unique: true
    t.index ["user_id"], name: "index_in_user_uris_on_user_id"
  end

  create_table "media", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "tweet_id"
    t.string "medium_own_id", default: "UNKNOWN", null: false
    t.string "uri", default: "UNKNOWN", null: false
    t.string "thumbnail_uri", default: "UNKNOWN", null: false
    t.string "media_type", default: "UNKNOWN", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["medium_own_id"], name: "index_media_on_medium_own_id"
    t.index ["tweet_id", "medium_own_id"], name: "index_media_on_tweet_id_and_medium_own_id", unique: true
    t.index ["tweet_id"], name: "index_media_on_tweet_id"
  end

  create_table "search_words", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "word"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["word"], name: "index_search_words_on_word", unique: true
  end

  create_table "tweets", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "tweet_number"
    t.bigint "user_id"
    t.boolean "has_user_mentions", default: false, null: false
    t.boolean "has_uris", default: false, null: false
    t.boolean "has_symbols", default: false, null: false
    t.boolean "has_media", default: false, null: false
    t.boolean "has_hashtags", default: false, null: false
    t.boolean "is_retweet", default: false, null: false
    t.datetime "tweeted_at", default: "1980-01-01 21:00:00", null: false
    t.string "uri", default: "UNKNOWN", null: false
    t.string "client_name", default: "UNKNOWN", null: false
    t.integer "retweet_count", default: -1, null: false
    t.string "lang", default: "UNKNOWN", null: false
    t.string "in_reply_to_user_id", default: "NO_USER_ID", null: false
    t.string "in_reply_to_status_id", default: "NO STATUS ID", null: false
    t.string "in_reply_to_screen_name", default: "NO SCREEN NAME", null: false
    t.integer "favorite_count", default: -1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.text "text", null: false
    t.bigint "search_word_id"
    t.index ["deleted_at"], name: "index_tweets_on_deleted_at"
    t.index ["search_word_id"], name: "index_tweets_on_search_word_id"
    t.index ["tweet_number"], name: "index_tweets_on_tweet_number", unique: true
    t.index ["user_id"], name: "index_tweets_on_user_id"
  end

  create_table "user_mentions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "tweet_id"
    t.bigint "user_id"
    t.string "indices", default: "UNKNOWN", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tweet_id", "user_id", "indices"], name: "index_user_mentions_on_tweet_id_and_user_id_and_indices", unique: true
    t.index ["tweet_id"], name: "index_user_mentions_on_tweet_id"
    t.index ["user_id"], name: "index_user_mentions_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "screen_name", default: "", null: false
    t.string "name", default: "", null: false
    t.string "user_number", default: "", null: false
    t.string "description", default: "", null: false
    t.string "uri", default: "", null: false
    t.string "uri_t_co", default: "UNKNOWN", null: false
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
    t.datetime "account_created_at", default: "1980-01-01 03:00:00", null: false
    t.string "connections", default: "", null: false
    t.string "email", default: "", null: false
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["user_number"], name: "index_users_on_user_number", unique: true
  end

  add_foreign_key "hashtags", "tweets"
  add_foreign_key "in_tweet_uris", "tweets"
  add_foreign_key "in_user_uris", "users"
  add_foreign_key "media", "tweets"
  add_foreign_key "tweets", "users"
  add_foreign_key "user_mentions", "tweets"
  add_foreign_key "user_mentions", "users"
end
