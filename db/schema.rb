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

ActiveRecord::Schema.define(:version => 20110128014856) do

  create_table "chat_messages", :force => true do |t|
    t.string   "message"
    t.integer  "log_event_id"
    t.integer  "player_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "log_events", :force => true do |t|
    t.string   "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", :force => true do |t|
    t.string   "name"
    t.datetime "last_logged_in_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "warp_points", :force => true do |t|
    t.float    "x"
    t.float    "y"
    t.float    "z"
    t.string   "name"
    t.integer  "player_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "worlds", :force => true do |t|
    t.string  "level_name"
    t.boolean "hello_world"
    t.boolean "spawn_monsters"
    t.boolean "spawn_animals"
    t.boolean "online_mode"
    t.integer "max_players"
    t.boolean "pvp"
  end

end
