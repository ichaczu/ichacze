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

ActiveRecord::Schema.define(version: 20151017155738) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "borrowers", force: :cascade do |t|
    t.string   "first_name",       null: false
    t.string   "last_name",        null: false
    t.text     "address",          null: false
    t.string   "pesel",            null: false
    t.string   "id_series_number", null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "guarantors", force: :cascade do |t|
    t.string   "first_name",       null: false
    t.string   "last_name",        null: false
    t.text     "address",          null: false
    t.string   "pesel",            null: false
    t.string   "id_series_number", null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "installments", force: :cascade do |t|
    t.integer  "loan_id"
    t.integer  "amount"
    t.string   "status",     default: "unpaid"
    t.datetime "payday"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.datetime "monit_sent"
    t.datetime "paid_at"
    t.integer  "order"
  end

  add_index "installments", ["loan_id"], name: "index_installments_on_loan_id", using: :btree

  create_table "loans", force: :cascade do |t|
    t.integer  "borrower_id"
    t.integer  "guarantor_id"
    t.integer  "duration"
    t.integer  "amount"
    t.integer  "rate_of_interest",    default: 8
    t.datetime "end_date"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "amount_paid"
    t.string   "status",              default: "unpaid"
    t.string   "place_of_conclusion"
    t.datetime "day_of_conclusion"
    t.integer  "user_id"
    t.string   "id_number"
  end

  add_index "loans", ["borrower_id"], name: "index_loans_on_borrower_id", using: :btree
  add_index "loans", ["guarantor_id"], name: "index_loans_on_guarantor_id", using: :btree
  add_index "loans", ["user_id"], name: "index_loans_on_user_id", using: :btree

  create_table "monits", force: :cascade do |t|
    t.integer  "installment_id"
    t.boolean  "active"
    t.datetime "last_visit_at"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "monits", ["installment_id"], name: "index_monits_on_installment_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "visits", force: :cascade do |t|
    t.integer  "monit_id"
    t.string   "report_url"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.datetime "date_of_visit"
  end

  add_index "visits", ["monit_id"], name: "index_visits_on_monit_id", using: :btree

  add_foreign_key "installments", "loans"
  add_foreign_key "loans", "borrowers"
  add_foreign_key "loans", "guarantors"
  add_foreign_key "loans", "users"
  add_foreign_key "monits", "installments"
  add_foreign_key "visits", "monits"
end
