# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_08_17_000000) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "connected_services", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "provider"
    t.string "uid"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_connected_services_on_user_id"
  end

  create_table "dry_foods", force: :cascade do |t|
    t.decimal "amount"
    t.decimal "average_used_amount"
    t.string "brand"
    t.datetime "created_at", null: false
    t.date "days_remaining"
    t.string "description"
    t.string "food_type"
    t.decimal "left_amount"
    t.decimal "total_ate_amount"
    t.datetime "updated_at", null: false
    t.decimal "used_amount"
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_dry_foods_on_user_id"
  end

  create_table "health_checks", force: :cascade do |t|
    t.decimal "alb"
    t.decimal "alkp"
    t.decimal "alt"
    t.decimal "amyl"
    t.decimal "baso"
    t.decimal "bun"
    t.decimal "ca"
    t.decimal "chol"
    t.decimal "cl"
    t.decimal "crea"
    t.datetime "created_at", null: false
    t.decimal "eos"
    t.date "exam_date"
    t.string "fbnp"
    t.string "felv"
    t.string "fiv"
    t.decimal "fpl2"
    t.decimal "ggt"
    t.decimal "glob"
    t.decimal "glu"
    t.decimal "hct"
    t.decimal "hgb"
    t.decimal "k"
    t.integer "lipa"
    t.decimal "lym"
    t.decimal "mch"
    t.decimal "mchc"
    t.decimal "mcv"
    t.decimal "mono"
    t.decimal "mpv"
    t.decimal "na"
    t.decimal "neu"
    t.integer "osm_cal"
    t.decimal "pct"
    t.integer "pet_id", null: false
    t.decimal "phos"
    t.integer "plt"
    t.decimal "rbc"
    t.decimal "rdw"
    t.decimal "retic"
    t.decimal "retic_hgb"
    t.decimal "tbil"
    t.decimal "tp"
    t.datetime "updated_at", null: false
    t.decimal "wbc"
    t.index ["pet_id"], name: "index_health_checks_on_pet_id"
  end

  create_table "pets", force: :cascade do |t|
    t.datetime "birthday"
    t.string "breed"
    t.datetime "created_at", null: false
    t.string "gender"
    t.string "petname"
    t.string "share_token"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.decimal "weight"
    t.index ["share_token"], name: "index_pets_on_share_token"
    t.index ["user_id"], name: "index_pets_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "ip_address"
    t.datetime "updated_at", null: false
    t.string "user_agent"
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "solid_cache_entries", force: :cascade do |t|
    t.integer "byte_size", limit: 8, default: 0, null: false
    t.datetime "created_at", null: false
    t.binary "key", limit: 1024, null: false
    t.integer "key_hash", limit: 8, null: false
    t.binary "value", limit: 536870912, null: false
    t.index ["key_hash", "created_at"], name: "index_solid_cache_entries_on_key_hash_and_created_at"
    t.index ["key_hash"], name: "index_solid_cache_entries_on_key_hash", unique: true
  end

  create_table "solid_queue_blocked_executions", force: :cascade do |t|
    t.string "concurrency_key", null: false
    t.datetime "created_at", null: false
    t.datetime "expires_at", null: false
    t.bigint "job_id", null: false
    t.integer "priority", default: 0, null: false
    t.string "queue_name", null: false
    t.index ["concurrency_key", "priority", "job_id"], name: "index_solid_queue_blocked_executions_for_release"
    t.index ["expires_at", "concurrency_key"], name: "index_solid_queue_blocked_executions_for_maintenance"
    t.index ["job_id"], name: "index_solid_queue_blocked_executions_on_job_id", unique: true
  end

  create_table "solid_queue_claimed_executions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "job_id", null: false
    t.bigint "process_id"
    t.index ["job_id"], name: "index_solid_queue_claimed_executions_on_job_id", unique: true
    t.index ["process_id", "job_id"], name: "index_solid_queue_claimed_executions_on_process_id_and_job_id"
  end

  create_table "solid_queue_failed_executions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "error"
    t.bigint "job_id", null: false
    t.index ["job_id"], name: "index_solid_queue_failed_executions_on_job_id", unique: true
  end

  create_table "solid_queue_jobs", force: :cascade do |t|
    t.string "active_job_id"
    t.text "arguments"
    t.string "class_name", null: false
    t.string "concurrency_key"
    t.datetime "created_at", null: false
    t.datetime "finished_at"
    t.integer "priority", default: 0, null: false
    t.string "queue_name", null: false
    t.datetime "scheduled_at"
    t.datetime "updated_at", null: false
    t.index ["active_job_id"], name: "index_solid_queue_jobs_on_active_job_id"
    t.index ["class_name"], name: "index_solid_queue_jobs_on_class_name"
    t.index ["finished_at"], name: "index_solid_queue_jobs_on_finished_at"
    t.index ["queue_name", "finished_at"], name: "index_solid_queue_jobs_for_filtering"
    t.index ["scheduled_at", "finished_at"], name: "index_solid_queue_jobs_for_alerting"
  end

  create_table "solid_queue_pauses", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "queue_name", null: false
    t.index ["queue_name"], name: "index_solid_queue_pauses_on_queue_name", unique: true
  end

  create_table "solid_queue_processes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "hostname"
    t.string "kind", null: false
    t.datetime "last_heartbeat_at", null: false
    t.text "metadata"
    t.string "name", null: false
    t.integer "pid", null: false
    t.bigint "supervisor_id"
    t.index ["last_heartbeat_at"], name: "index_solid_queue_processes_on_last_heartbeat_at"
    t.index ["name", "supervisor_id"], name: "index_solid_queue_processes_on_name_and_supervisor_id", unique: true
    t.index ["supervisor_id"], name: "index_solid_queue_processes_on_supervisor_id"
  end

  create_table "solid_queue_ready_executions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "job_id", null: false
    t.integer "priority", default: 0, null: false
    t.string "queue_name", null: false
    t.index ["job_id"], name: "index_solid_queue_ready_executions_on_job_id", unique: true
    t.index ["priority", "job_id"], name: "index_solid_queue_poll_all"
    t.index ["queue_name", "priority", "job_id"], name: "index_solid_queue_poll_by_queue"
  end

  create_table "solid_queue_recurring_executions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "job_id", null: false
    t.datetime "run_at", null: false
    t.string "task_key", null: false
    t.index ["job_id"], name: "index_solid_queue_recurring_executions_on_job_id", unique: true
    t.index ["task_key", "run_at"], name: "index_solid_queue_recurring_executions_on_task_key_and_run_at", unique: true
  end

  create_table "solid_queue_recurring_tasks", force: :cascade do |t|
    t.text "arguments"
    t.string "class_name"
    t.string "command", limit: 2048
    t.datetime "created_at", null: false
    t.text "description"
    t.string "key", null: false
    t.integer "priority", default: 0
    t.string "queue_name"
    t.string "schedule", null: false
    t.boolean "static", default: true, null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_solid_queue_recurring_tasks_on_key", unique: true
    t.index ["static"], name: "index_solid_queue_recurring_tasks_on_static"
  end

  create_table "solid_queue_scheduled_executions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "job_id", null: false
    t.integer "priority", default: 0, null: false
    t.string "queue_name", null: false
    t.datetime "scheduled_at", null: false
    t.index ["job_id"], name: "index_solid_queue_scheduled_executions_on_job_id", unique: true
    t.index ["scheduled_at", "priority", "job_id"], name: "index_solid_queue_dispatch_all"
  end

  create_table "solid_queue_semaphores", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "expires_at", null: false
    t.string "key", null: false
    t.datetime "updated_at", null: false
    t.integer "value", default: 1, null: false
    t.index ["expires_at"], name: "index_solid_queue_semaphores_on_expires_at"
    t.index ["key", "value"], name: "index_solid_queue_semaphores_on_key_and_value"
    t.index ["key"], name: "index_solid_queue_semaphores_on_key", unique: true
  end

  create_table "trackers", force: :cascade do |t|
    t.decimal "amount", precision: 5, scale: 2
    t.boolean "archived_dry_food", default: false, null: false
    t.string "brand"
    t.string "come_back_to_eat"
    t.datetime "created_at", null: false
    t.date "date"
    t.string "description"
    t.integer "dry_food_id"
    t.integer "favorite_score", default: 0
    t.time "feed_time"
    t.string "food_type"
    t.integer "frequency"
    t.string "hungry"
    t.decimal "left_amount", precision: 5, scale: 2
    t.string "love"
    t.string "note"
    t.integer "pet_id", null: false
    t.string "result"
    t.decimal "total_ate_amount", precision: 5, scale: 2
    t.datetime "updated_at", null: false
    t.decimal "weight", precision: 4, scale: 2
    t.index ["dry_food_id"], name: "index_trackers_on_dry_food_id"
    t.index ["pet_id"], name: "index_trackers_on_pet_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "current_sign_in_at"
    t.string "email_address", null: false
    t.string "gemini_api_key"
    t.datetime "last_sign_in_at"
    t.string "password_digest", null: false
    t.integer "sign_in_count"
    t.string "timezone"
    t.datetime "updated_at", null: false
    t.string "username"
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  create_table "vet_visit_members", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.integer "vet_visit_id", null: false
    t.index ["user_id"], name: "index_vet_visit_members_on_user_id"
    t.index ["vet_visit_id", "user_id"], name: "index_vet_visit_members_on_vet_visit_id_and_user_id", unique: true
    t.index ["vet_visit_id"], name: "index_vet_visit_members_on_vet_visit_id"
  end

  create_table "vet_visits", force: :cascade do |t|
    t.text "answer"
    t.date "answered_date"
    t.integer "consultation_time"
    t.datetime "created_at", null: false
    t.integer "pet_id", null: false
    t.string "purpose"
    t.text "question", null: false
    t.datetime "updated_at", null: false
    t.string "vet_name"
    t.date "visit_date", null: false
    t.integer "waiting_time"
    t.index ["pet_id"], name: "index_vet_visits_on_pet_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "connected_services", "users"
  add_foreign_key "dry_foods", "Users", column: "user_id"
  add_foreign_key "health_checks", "pets"
  add_foreign_key "pets", "users"
  add_foreign_key "sessions", "users"
  add_foreign_key "solid_queue_blocked_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_claimed_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_failed_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_ready_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_recurring_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_scheduled_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "trackers", "dry_foods"
  add_foreign_key "trackers", "pets"
  add_foreign_key "vet_visit_members", "users"
  add_foreign_key "vet_visit_members", "vet_visits"
  add_foreign_key "vet_visits", "pets"
end
