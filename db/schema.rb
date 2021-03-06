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

ActiveRecord::Schema.define(version: 20160607232817) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "courses", force: :cascade do |t|
    t.string "title"
    t.text   "description"
    t.string "password_digest"
  end

  create_table "enrollments", force: :cascade do |t|
    t.integer "course_id"
    t.string  "confirm_token"
    t.integer "student_placeholder"
    t.integer "student_id"
    t.index ["course_id"], name: "index_enrollments_on_course_id", using: :btree
  end

  create_table "instructor_courses", force: :cascade do |t|
    t.integer "instructor_id"
    t.integer "course_id"
    t.index ["course_id"], name: "index_instructor_courses_on_course_id", using: :btree
    t.index ["instructor_id"], name: "index_instructor_courses_on_instructor_id", using: :btree
  end

  create_table "instructors", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
  end

  create_table "lectures", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "instructor_id"
    t.integer  "course_id"
    t.boolean  "locked"
    t.datetime "finish_time"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["course_id"], name: "index_lectures_on_course_id", using: :btree
    t.index ["instructor_id"], name: "index_lectures_on_instructor_id", using: :btree
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "lecture_id"
    t.text     "content"
    t.boolean  "locked"
    t.boolean  "anonymous",  default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["lecture_id"], name: "index_reviews_on_lecture_id", using: :btree
    t.index ["student_id"], name: "index_reviews_on_student_id", using: :btree
  end

  create_table "students", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
  end

  add_foreign_key "enrollments", "courses"
  add_foreign_key "instructor_courses", "courses"
  add_foreign_key "instructor_courses", "instructors"
  add_foreign_key "lectures", "courses"
  add_foreign_key "lectures", "instructors"
  add_foreign_key "reviews", "lectures"
  add_foreign_key "reviews", "students"
end
