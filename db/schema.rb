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

ActiveRecord::Schema.define(version: 20140224035503) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "details", force: true do |t|
    t.integer  "identifier"
    t.text     "VIPBiteDeal"
    t.text     "dealDetail"
    t.string   "reservation"
    t.string   "operatinghour"
    t.string   "link"
    t.text     "comment"
    t.string   "imageFolder"
    t.string   "urbanspoonLink"
    t.string   "urbanspoonReview"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "restaurants", force: true do |t|
    t.integer  "identifier"
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "province"
    t.string   "postal"
    t.string   "imageUrl"
    t.string   "email"
    t.string   "phone"
    t.string   "VIPBiteDeal"
    t.float    "longitude"
    t.float    "latitude"
    t.string   "detailId"
    t.string   "search"
    t.datetime "modifiedDate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transactions", force: true do |t|
    t.string   "identifier"
    t.string   "userId"
    t.string   "subsription"
    t.string   "billingAddress"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "userId"
    t.string   "userEmail"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "password"
    t.datetime "expDate"
    t.boolean  "isAdmin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
