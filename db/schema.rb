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

ActiveRecord::Schema.define(version: 20200426193420) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.integer  "customer_id"
    t.string   "street"
    t.string   "city"
    t.string   "zip"
    t.string   "country"
    t.text     "note"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "address"
    t.string   "level"
    t.string   "latitude"
    t.string   "longitude"
  end

  add_index "addresses", ["customer_id"], name: "index_addresses_on_customer_id", using: :btree

  create_table "advertisers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  create_table "banner_statistics", force: :cascade do |t|
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "banner_id"
    t.string   "ip"
    t.integer  "impressions", default: 0, null: false
    t.integer  "clicks",      default: 0, null: false
  end

  create_table "banners", force: :cascade do |t|
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "advertiser_id"
    t.string   "name"
    t.string   "url"
    t.string   "kind"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.date     "valid_from"
    t.date     "valid_to"
    t.integer  "priority"
    t.string   "file_kind"
  end

  create_table "cart_items", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "session_id"
    t.integer  "product_id"
    t.string   "product_name"
    t.integer  "product_price"
    t.string   "product_currency"
    t.integer  "amount"
    t.string   "sub_product_ids"
    t.string   "sub_product_names"
    t.string   "sub_product_prices"
    t.string   "sub_product_currencies"
    t.integer  "restaurant_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string   "email",                   default: "", null: false
    t.string   "encrypted_password",      default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",           default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "name_firstname",                       null: false
    t.string   "name_lastname"
    t.string   "phone"
    t.boolean  "personal_data_agreement"
    t.boolean  "terms_agreement"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "main_address"
    t.integer  "bonus",                   default: 0,  null: false
    t.string   "api_token"
  end

  add_index "customers", ["api_token"], name: "index_customers_on_api_token", unique: true, using: :btree
  add_index "customers", ["email"], name: "index_customers_on_email", unique: true, using: :btree
  add_index "customers", ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true, using: :btree

  create_table "delivery_map_zones", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "delivery_map_id"
    t.string   "polygon_points"
    t.float    "polygon_top"
    t.float    "polygon_bottom"
    t.float    "polygon_left"
    t.float    "polygon_right"
    t.integer  "min_order_price"
    t.integer  "delivery_price"
    t.integer  "package_price"
    t.integer  "delivery_time"
    t.string   "name"
    t.integer  "level"
    t.boolean  "order_below_min_price"
  end

  create_table "delivery_maps", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.boolean  "restrict_zone"
    t.boolean  "order_below_min_price"
  end

  create_table "kitchens", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "force_closed"
    t.time     "max_delivery_time"
    t.text     "force_closed_note"
    t.string   "force_closed_picture_file_name"
    t.string   "force_closed_picture_content_type"
    t.integer  "force_closed_picture_file_size"
    t.datetime "force_closed_picture_updated_at"
  end

  create_table "menus", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "key"
    t.string   "name"
  end

  create_table "menus_pages", id: false, force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "menu_id"
    t.integer  "page_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_id"
    t.integer  "product_id"
    t.string   "product_name"
    t.integer  "product_price"
    t.string   "product_currency"
    t.integer  "amount"
    t.string   "sub_product_ids"
    t.string   "sub_product_names"
    t.string   "sub_product_prices"
    t.string   "sub_product_currencies"
    t.integer  "restaurant_id"
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "session_id"
    t.integer  "customer_id"
    t.string   "customer_name"
    t.string   "customer_email"
    t.string   "customer_phone"
    t.string   "billing_name"
    t.string   "billing_address_street"
    t.string   "billing_address_number"
    t.string   "billing_address_postcode"
    t.string   "billing_address_city"
    t.string   "payment_id"
    t.string   "payment_type"
    t.datetime "paid_at"
    t.string   "currency"
    t.string   "delivery_type"
    t.text     "note"
    t.float    "customer_location_latitude"
    t.float    "customer_location_longitude"
    t.string   "customer_location_address"
    t.integer  "final_price"
    t.datetime "delivery_time"
    t.string   "customer_location_level"
    t.datetime "forwarded_at"
    t.integer  "process_state",               default: 0,     null: false
    t.datetime "kitchen_at"
    t.datetime "shipping_at"
    t.datetime "delivered_at"
    t.datetime "closed_at"
    t.boolean  "eligible_for_bonus",          default: false, null: false
    t.boolean  "bonus_assigned",              default: false, null: false
    t.integer  "used_bonus",                  default: 0,     null: false
    t.datetime "canceled_at"
  end

  create_table "page_blocks", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.integer  "page_id"
    t.integer  "subject_id"
    t.string   "subject_type"
  end

  create_table "pages", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.integer  "lft",                                 null: false
    t.integer  "rgt",                                 null: false
    t.integer  "depth",                   default: 0, null: false
    t.string   "title"
    t.string   "nature"
    t.integer  "model_id"
    t.string   "model_type"
    t.string   "url"
    t.string   "background_file_name"
    t.string   "background_content_type"
    t.integer  "background_file_size"
    t.datetime "background_updated_at"
    t.string   "layout"
    t.string   "meta_title"
    t.string   "meta_description"
  end

  add_index "pages", ["lft"], name: "index_pages_on_lft", using: :btree
  add_index "pages", ["parent_id"], name: "index_pages_on_parent_id", using: :btree
  add_index "pages", ["rgt"], name: "index_pages_on_rgt", using: :btree

  create_table "product_attachments", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.string   "title"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  create_table "product_attachments_products", id: false, force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "product_id"
    t.integer  "product_attachment_id"
  end

  create_table "product_categories", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.integer  "lft",                    null: false
    t.integer  "rgt",                    null: false
    t.integer  "depth",      default: 0, null: false
    t.string   "name"
  end

  add_index "product_categories", ["lft"], name: "index_product_categories_on_lft", using: :btree
  add_index "product_categories", ["parent_id"], name: "index_product_categories_on_parent_id", using: :btree
  add_index "product_categories", ["rgt"], name: "index_product_categories_on_rgt", using: :btree

  create_table "product_categories_products", id: false, force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "product_id"
    t.integer  "product_category_id"
  end

  create_table "product_photos", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.integer  "product_id"
    t.string   "title"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.integer  "picture_crop_x"
    t.integer  "picture_crop_y"
    t.integer  "picture_crop_w"
    t.integer  "picture_crop_h"
  end

  create_table "product_tickers", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "key"
  end

  create_table "product_tickers_products", id: false, force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "product_id"
    t.integer  "product_ticker_id"
  end

  create_table "product_variants", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.integer  "product_id"
    t.string   "name"
    t.boolean  "required"
    t.string   "operator"
  end

  create_table "product_variants_products", id: false, force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "product_id"
    t.integer  "product_variant_id"
  end

  create_table "products", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.string   "name"
    t.string   "catalogue_number"
    t.string   "ean"
    t.text     "perex"
    t.text     "content"
    t.integer  "height"
    t.integer  "width"
    t.integer  "depth"
    t.integer  "weight"
    t.integer  "capacity"
    t.integer  "price"
    t.string   "currency"
    t.string   "keywords"
    t.string   "description"
    t.integer  "default_product_category_id"
    t.string   "amount"
  end

  create_table "restaurants", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.string   "name"
    t.string   "perex"
    t.string   "assortment"
    t.text     "content"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "profile_picture_file_name"
    t.string   "profile_picture_content_type"
    t.integer  "profile_picture_file_size"
    t.datetime "profile_picture_updated_at"
    t.string   "background_picture_file_name"
    t.string   "background_picture_content_type"
    t.integer  "background_picture_file_size"
    t.datetime "background_picture_updated_at"
    t.string   "max_delivery_time"
    t.string   "payment_types"
    t.string   "voucher_types"
    t.integer  "product_collection_id"
    t.integer  "delivery_map_id"
    t.float    "opening_hours_monday_min"
    t.float    "opening_hours_monday_max"
    t.float    "opening_hours_tuesday_min"
    t.float    "opening_hours_tuesday_max"
    t.float    "opening_hours_wednesday_min"
    t.float    "opening_hours_wednesday_max"
    t.float    "opening_hours_thursday_min"
    t.float    "opening_hours_thursday_max"
    t.float    "opening_hours_friday_min"
    t.float    "opening_hours_friday_max"
    t.float    "opening_hours_saturday_min"
    t.float    "opening_hours_saturday_max"
    t.float    "opening_hours_sunday_min"
    t.float    "opening_hours_sunday_max"
    t.boolean  "force_closed"
    t.boolean  "hidden"
    t.string   "type"
    t.string   "product_collection_type"
    t.string   "force_closed_note"
    t.integer  "profile_picture_crop_x"
    t.integer  "profile_picture_crop_y"
    t.integer  "profile_picture_crop_w"
    t.integer  "profile_picture_crop_h"
    t.boolean  "show_logo_over_profile_picture"
  end

  create_table "sessions", id: false, force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "id",                 null: false
    t.float    "location_latitude"
    t.float    "location_longitude"
    t.string   "location_address"
    t.string   "location_level"
  end

  add_index "sessions", ["id"], name: "index_sessions_on_id", unique: true, using: :btree

  create_table "settings", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.string   "key"
    t.string   "value"
    t.string   "kind"
    t.string   "category"
  end

  add_index "settings", ["key"], name: "index_settings_on_key", using: :btree

  create_table "slugs", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug_language"
    t.string   "original"
    t.string   "translation"
  end

  create_table "special_actions", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "title"
    t.string   "color"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["context"], name: "index_taggings_on_context", using: :btree
  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy", using: :btree
  add_index "taggings", ["taggable_id"], name: "index_taggings_on_taggable_id", using: :btree
  add_index "taggings", ["taggable_type"], name: "index_taggings_on_taggable_type", using: :btree
  add_index "taggings", ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type", using: :btree
  add_index "taggings", ["tagger_id"], name: "index_taggings_on_tagger_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
    t.integer "position"
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "text_attachments", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.string   "kind"
  end

  create_table "texts", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "content"
    t.string   "key"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "role"
    t.datetime "locked_at"
    t.string   "name_firstname"
    t.string   "name_lastname"
  end

  add_foreign_key "addresses", "customers"
  add_foreign_key "customers", "addresses", column: "main_address"
end
