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

ActiveRecord::Schema.define(version: 20181119111858) do

  create_table "activities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "circle_id"
    t.bigint "place_content_id"
    t.integer "max_member_number"
    t.text "auto_reply_comment"
    t.date "date"
    t.time "start_time"
    t.time "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["circle_id"], name: "index_activities_on_circle_id"
    t.index ["place_content_id"], name: "index_activities_on_place_content_id"
  end

  create_table "activity_reviews", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.bigint "activity_id"
    t.integer "evaluation"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_activity_reviews_on_activity_id"
    t.index ["user_id"], name: "index_activity_reviews_on_user_id"
  end

  create_table "applications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.bigint "activity_id"
    t.integer "join_member_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", limit: 1, default: 0, null: false
    t.index ["activity_id"], name: "index_applications_on_activity_id"
    t.index ["user_id"], name: "index_applications_on_user_id"
  end

  create_table "areas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.bigint "city_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_areas_on_city_id"
  end

  create_table "chats", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "activity_id"
    t.bigint "application_id"
    t.integer "speaker", limit: 1, default: 0, null: false
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_chats_on_activity_id"
    t.index ["application_id"], name: "index_chats_on_application_id"
  end

  create_table "circle_contents", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "circle_id"
    t.bigint "content_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["circle_id"], name: "index_circle_contents_on_circle_id"
    t.index ["content_id"], name: "index_circle_contents_on_content_id"
  end

  create_table "circles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.bigint "owner_id"
    t.text "introduction"
    t.string "introduction_picture_url"
    t.text "default_auto_reply_comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_circles_on_owner_id"
  end

  create_table "cities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.bigint "prefecture_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prefecture_id"], name: "index_cities_on_prefecture_id"
  end

  create_table "contents", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.bigint "event_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_type_id"], name: "index_contents_on_event_type_id"
  end

  create_table "event_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "activity_id"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_messages_on_activity_id"
  end

  create_table "place_contents", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "place_id"
    t.bigint "content_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["content_id"], name: "index_place_contents_on_content_id"
    t.index ["place_id"], name: "index_place_contents_on_place_id"
  end

  create_table "places", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "tel"
    t.string "address"
    t.bigint "area_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["area_id"], name: "index_places_on_area_id"
  end

  create_table "prefectures", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_areas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.bigint "area_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["area_id"], name: "index_user_areas_on_area_id"
    t.index ["user_id"], name: "index_user_areas_on_user_id"
  end

  create_table "user_blocks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.bigint "circle_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["circle_id"], name: "index_user_blocks_on_circle_id"
    t.index ["user_id"], name: "index_user_blocks_on_user_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uid"
    t.string "provider"
    t.string "display_name"
    t.text "status_message"
    t.string "picture_url"
    t.string "line_user_id"
    t.bigint "owned_circle_id"
    t.index ["owned_circle_id"], name: "index_users_on_owned_circle_id"
  end

  add_foreign_key "activities", "circles"
  add_foreign_key "activities", "place_contents"
  add_foreign_key "activity_reviews", "activities"
  add_foreign_key "activity_reviews", "users"
  add_foreign_key "applications", "activities"
  add_foreign_key "applications", "users"
  add_foreign_key "areas", "cities"
  add_foreign_key "chats", "activities"
  add_foreign_key "chats", "applications"
  add_foreign_key "circle_contents", "circles"
  add_foreign_key "circle_contents", "contents"
  add_foreign_key "circles", "users", column: "owner_id"
  add_foreign_key "cities", "prefectures"
  add_foreign_key "contents", "event_types"
  add_foreign_key "messages", "activities"
  add_foreign_key "place_contents", "contents"
  add_foreign_key "place_contents", "places"
  add_foreign_key "places", "areas"
  add_foreign_key "user_areas", "areas"
  add_foreign_key "user_areas", "users"
  add_foreign_key "user_blocks", "circles"
  add_foreign_key "user_blocks", "users"
  add_foreign_key "users", "circles", column: "owned_circle_id"
end
