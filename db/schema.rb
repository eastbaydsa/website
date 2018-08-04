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

ActiveRecord::Schema.define(version: 20180804214409) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "blog_posts", force: :cascade do |t|
    t.text "title"
    t.text "content"
    t.datetime "posted_at"
    t.string "slug", null: false
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "featured_image"
    t.boolean "listed", default: true
    t.string "meta_title"
    t.string "meta_desc"
    t.boolean "featured", default: true, null: false
    t.index ["author_id"], name: "index_blog_posts_on_author_id"
    t.index ["slug"], name: "index_blog_posts_on_slug", unique: true
  end

  create_table "menu_items", force: :cascade do |t|
    t.string "label"
    t.string "slug"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "container"
  end

  create_table "pages", force: :cascade do |t|
    t.text "title"
    t.text "content"
    t.string "slug", null: false
    t.boolean "show_in_menu"
    t.integer "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "subtitle"
    t.boolean "listed", default: true
    t.boolean "show_form", default: false, null: false
    t.string "form_tags"
    t.string "background_image_url"
    t.string "meta_title"
    t.string "meta_desc"
    t.boolean "form_collect_phone", default: false, null: false
    t.index ["slug"], name: "index_pages_on_slug", unique: true
  end

  create_table "redirects", force: :cascade do |t|
    t.string "from_path"
    t.string "to_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "clicks", default: 0
  end

end
