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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131110022044) do

  create_table "answers", :force => true do |t|
    t.text     "body"
    t.integer  "question_id"
    t.integer  "user_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.boolean  "accepted",    :default => false
  end

  add_index "answers", ["question_id", "user_id"], :name => "index_answers_on_question_id_and_user_id", :unique => true
  add_index "answers", ["question_id"], :name => "index_answers_on_question_id"
  add_index "answers", ["user_id"], :name => "index_answers_on_user_id"

  create_table "comments", :force => true do |t|
    t.text     "body"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "edit_suggestions", :force => true do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "editable_id"
    t.string   "editable_type"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.boolean  "accepted",      :default => false
  end

  add_index "edit_suggestions", ["user_id"], :name => "index_edit_suggestions_on_user_id"

  create_table "friendly_id_slugs", :force => true do |t|
    t.string   "slug",                         :null => false
    t.integer  "sluggable_id",                 :null => false
    t.string   "sluggable_type", :limit => 40
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type"], :name => "index_friendly_id_slugs_on_slug_and_sluggable_type", :unique => true
  add_index "friendly_id_slugs", ["sluggable_id"], :name => "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], :name => "index_friendly_id_slugs_on_sluggable_type"

  create_table "questions", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "questions", ["user_id"], :name => "index_questions_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "username",                       :null => false
    t.string   "password_digest",                :null => false
    t.string   "session_token",                  :null => false
    t.integer  "points",          :default => 5
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.string   "slug"
    t.string   "email"
  end

  add_index "users", ["session_token"], :name => "index_users_on_session_token"
  add_index "users", ["slug"], :name => "index_users_on_slug", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

  create_table "votes", :force => true do |t|
    t.string   "direction"
    t.integer  "user_id"
    t.integer  "voteable_id"
    t.string   "voteable_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "votes", ["user_id", "voteable_id", "voteable_type"], :name => "index_votes_on_user_id_and_voteable_id_and_voteable_type", :unique => true
  add_index "votes", ["user_id"], :name => "index_votes_on_user_id"

end
