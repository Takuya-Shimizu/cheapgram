ActiveRecord::Schema.define(version: 2023_01_05_135038) do

  enable_extension "plpgsql"

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "feed_id"
    t.index ["feed_id"], name: "index_favorites_on_feed_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "feeds", force: :cascade do |t|
    t.text "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.text "title"
    t.text "content"
    t.index ["user_id"], name: "index_feeds_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "image"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "favorites", "feeds"
  add_foreign_key "favorites", "users"
  add_foreign_key "feeds", "users"
end
