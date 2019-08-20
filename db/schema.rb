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

ActiveRecord::Schema.define(version: 2019_08_20_075307) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "body"
    t.integer "commentable_id"
    t.string "commentable_type"
    t.string "image"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "images", force: :cascade do |t|
    t.bigint "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "data"
    t.index ["post_id"], name: "index_images_on_post_id"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "likeable_type"
    t.integer "likeable_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "post_images", force: :cascade do |t|
    t.string "data"
    t.bigint "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_post_images_on_post_id"
  end

  create_table "posts", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.text "body"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "surname"
    t.string "birth_date"
    t.string "was_online"
    t.string "avatar"
    t.string "provider"
    t.string "uid"
    t.string "provider_img"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "comments", "users"
  add_foreign_key "images", "posts"
  add_foreign_key "likes", "users"
  add_foreign_key "post_images", "posts"
  add_foreign_key "posts", "users"
end
