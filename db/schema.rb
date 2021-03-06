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

ActiveRecord::Schema.define(:version => 20120724195355) do

  create_table "challenge_evidences", :force => true do |t|
    t.integer  "challenge_id"
    t.string   "image"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "external_url"
    t.string   "display_html"
    t.integer  "user_id"
  end

  create_table "challenges", :force => true do |t|
    t.string   "title"
    t.integer  "amount"
    t.integer  "project_id"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.string   "display_media"
    t.boolean  "met",                  :default => false
    t.integer  "target_funding_cents"
    t.integer  "user_id"
  end

  create_table "projects", :force => true do |t|
    t.string   "proposal_url"
    t.string   "fund_url"
    t.string   "image_url"
    t.string   "title"
    t.text     "short_description"
    t.text     "fulfillment_trailer"
    t.string   "percent_funded"
    t.string   "cost_to_complete"
    t.string   "total_price"
    t.string   "free_shipping"
    t.string   "teacher_name"
    t.string   "grade_level"
    t.string   "poverty_level"
    t.string   "school_name"
    t.string   "city"
    t.string   "zip"
    t.string   "state_abbr"
    t.string   "latitude"
    t.string   "longitude"
    t.string   "state"
    t.string   "subject"
    t.string   "resource_type"
    t.string   "expiration_date"
    t.string   "funding_status"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "donors_choose_id"
    t.integer  "amount_raised_cents"
  end

  create_table "users", :force => true do |t|
    t.string   "screen_name"
    t.string   "uid"
    t.string   "provider"
    t.string   "profile_image_url"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "name"
  end

end
