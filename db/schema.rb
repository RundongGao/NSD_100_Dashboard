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

ActiveRecord::Schema.define(version: 20160305050843) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string  "symbol"
    t.decimal "market_cap_m"
    t.string  "sector"
    t.string  "industory"
    t.string  "name"
  end

  add_index "companies", ["symbol"], name: "index_companies_on_symbol", unique: true, using: :btree

  create_table "quotes", force: :cascade do |t|
    t.string  "symbol"
    t.date    "date"
    t.decimal "open"
    t.decimal "close"
    t.decimal "high"
    t.decimal "low"
    t.integer "volume",    limit: 8
    t.decimal "adj_close"
  end

  add_index "quotes", ["symbol", "date"], name: "index_quotes_on_symbol_and_date", unique: true, using: :btree

  add_foreign_key "quotes", "companies", column: "symbol", primary_key: "symbol", name: "quote_symbol_fkey"
end
