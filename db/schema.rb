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

ActiveRecord::Schema.define(:version => 20121115131332) do

  create_table "anagrams", :force => true do |t|
    t.string  "dictionary_id"
    t.integer "sorted_id"
    t.integer "word_id"
  end

  create_table "autocompletions", :force => true do |t|
    t.text    "prefix"
    t.text    "words"
    t.integer "dictionary_id"
  end

  add_index "autocompletions", ["prefix"], :name => "index_autocompletions_on_prefix"

  create_table "dictionaries", :force => true do |t|
    t.text     "name"
    t.text     "attribution"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "grid_types", :force => true do |t|
    t.integer  "dictionary_id"
    t.integer  "row_count"
    t.integer  "col_count"
    t.text     "status"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "grids", :force => true do |t|
    t.integer "gridtype"
    t.integer "orient"
    t.integer "nth"
    t.string  "word_id"
  end

  create_table "pop_scores", :force => true do |t|
    t.text    "word"
    t.integer "score"
    t.integer "dictionary_id"
  end

  create_table "sketches", :force => true do |t|
    t.integer "gridtype"
    t.string  "sketch"
  end

  create_table "words", :force => true do |t|
    t.text    "word"
    t.integer "dictionary_id"
    t.integer "processed"
  end

end
