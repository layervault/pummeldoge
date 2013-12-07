# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20131207175225) do

  create_table "movies", force: true do |t|
    t.string   "title"
    t.string   "movie_data_file_name"
    t.string   "movie_data_content_type"
    t.integer  "movie_data_file_size"
    t.datetime "movie_data_updated_at"
    t.string   "h264_file_name"
    t.string   "h264_content_type"
    t.integer  "h264_file_size"
    t.datetime "h264_updated_at"
    t.string   "gif_file_name"
    t.string   "gif_content_type"
    t.integer  "gif_file_size"
    t.datetime "gif_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "organization_permalink"
    t.string   "project_name"
    t.string   "folder_path"
    t.string   "file_name"
    t.integer  "user_id"
  end

  add_index "movies", ["user_id"], name: "index_movies_on_user_id"

  create_table "previews", force: true do |t|
    t.integer  "movie_id"
    t.string   "url"
    t.string   "preview_data_file_name"
    t.string   "preview_data_content_type"
    t.integer  "preview_data_file_size"
    t.datetime "preview_data_updated_at"
    t.string   "movie_data_file_name"
    t.string   "movie_data_content_type"
    t.integer  "movie_data_file_size"
    t.datetime "movie_data_updated_at"
    t.string   "gif_data_file_name"
    t.string   "gif_data_content_type"
    t.integer  "gif_data_file_size"
    t.datetime "gif_data_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "previews", ["movie_id"], name: "index_previews_on_movie_id"

  create_table "user_sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_sessions", ["session_id"], name: "index_user_sessions_on_session_id"
  add_index "user_sessions", ["updated_at"], name: "index_user_sessions_on_updated_at"

  create_table "users", force: true do |t|
    t.integer  "layervault_id"
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "is_admin"
    t.string   "access_token"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.string   "persistence_token", default: "", null: false
    t.datetime "last_login_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["layervault_id"], name: "index_users_on_layervault_id", unique: true
  add_index "users", ["persistence_token"], name: "index_users_on_persistence_token", unique: true

end
