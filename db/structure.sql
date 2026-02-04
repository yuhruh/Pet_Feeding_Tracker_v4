CREATE TABLE IF NOT EXISTS "schema_migrations" ("version" varchar NOT NULL PRIMARY KEY);
CREATE TABLE IF NOT EXISTS "ar_internal_metadata" ("key" varchar NOT NULL PRIMARY KEY, "value" varchar, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE TABLE IF NOT EXISTS "sessions" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer NOT NULL, "ip_address" varchar, "user_agent" varchar, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, CONSTRAINT "fk_rails_758836b4f0"
FOREIGN KEY ("user_id")
  REFERENCES "users" ("id")
);
CREATE INDEX "index_sessions_on_user_id" ON "sessions" ("user_id") /*application='PetTrackerV4'*/;
CREATE TABLE IF NOT EXISTS "pets" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "petname" varchar, "birthday" datetime(6), "weight" decimal, "gender" varchar, "breed" varchar, "user_id" integer NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, CONSTRAINT "fk_rails_0fa4bae6b1"
FOREIGN KEY ("user_id")
  REFERENCES "users" ("id")
);
CREATE INDEX "index_pets_on_user_id" ON "pets" ("user_id") /*application='PetTrackerV4'*/;
CREATE TABLE IF NOT EXISTS "active_storage_blobs" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "key" varchar NOT NULL, "filename" varchar NOT NULL, "content_type" varchar, "metadata" text, "service_name" varchar NOT NULL, "byte_size" bigint NOT NULL, "checksum" varchar, "created_at" datetime(6) NOT NULL);
CREATE UNIQUE INDEX "index_active_storage_blobs_on_key" ON "active_storage_blobs" ("key") /*application='PetTrackerV4'*/;
CREATE TABLE IF NOT EXISTS "active_storage_attachments" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar NOT NULL, "record_type" varchar NOT NULL, "record_id" bigint NOT NULL, "blob_id" bigint NOT NULL, "created_at" datetime(6) NOT NULL, CONSTRAINT "fk_rails_c3b3935057"
FOREIGN KEY ("blob_id")
  REFERENCES "active_storage_blobs" ("id")
);
CREATE INDEX "index_active_storage_attachments_on_blob_id" ON "active_storage_attachments" ("blob_id") /*application='PetTrackerV4'*/;
CREATE UNIQUE INDEX "index_active_storage_attachments_uniqueness" ON "active_storage_attachments" ("record_type", "record_id", "name", "blob_id") /*application='PetTrackerV4'*/;
CREATE TABLE IF NOT EXISTS "active_storage_variant_records" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "blob_id" bigint NOT NULL, "variation_digest" varchar NOT NULL, CONSTRAINT "fk_rails_993965df05"
FOREIGN KEY ("blob_id")
  REFERENCES "active_storage_blobs" ("id")
);
CREATE UNIQUE INDEX "index_active_storage_variant_records_uniqueness" ON "active_storage_variant_records" ("blob_id", "variation_digest") /*application='PetTrackerV4'*/;
CREATE TABLE IF NOT EXISTS "dry_foods" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "brand" varchar, "food_type" varchar, "description" varchar, "amount" decimal, "used_amount" decimal, "average_used_amount" decimal, "total_ate_amount" decimal, "left_amount" decimal, "days_remaining" date, "user_id" integer NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, CONSTRAINT "fk_rails_8b41e2b8f9"
FOREIGN KEY ("user_id")
  REFERENCES "users" ("id")
);
CREATE INDEX "index_dry_foods_on_user_id" ON "dry_foods" ("user_id") /*application='PetTrackerV4'*/;
CREATE TABLE IF NOT EXISTS "trackers" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "date" date, "feed_time" time, "come_back_to_eat" varchar, "food_type" varchar, "brand" varchar, "description" varchar, "hungry" varchar, "amount" decimal(5,2), "left_amount" decimal(5,2), "love" varchar, "total_ate_amount" decimal(5,2), "frequency" integer, "result" varchar, "favorite_score" integer DEFAULT 0, "note" varchar, "weight" decimal(4,2), "pet_id" integer NOT NULL, "dry_food_id" integer NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, CONSTRAINT "fk_rails_44d936d49f"
FOREIGN KEY ("pet_id")
  REFERENCES "pets" ("id")
, CONSTRAINT "fk_rails_6f5f73c25a"
FOREIGN KEY ("dry_food_id")
  REFERENCES "dry_foods" ("id")
);
CREATE INDEX "index_trackers_on_pet_id" ON "trackers" ("pet_id") /*application='PetTrackerV4'*/;
CREATE INDEX "index_trackers_on_dry_food_id" ON "trackers" ("dry_food_id") /*application='PetTrackerV4'*/;
CREATE TABLE IF NOT EXISTS "users" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "email_address" varchar NOT NULL, "password_digest" varchar NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, "username" varchar, "timezone" varchar, "sign_in_count" integer, "current_sign_in_at" datetime(6), "last_sign_in_at" datetime(6));
CREATE UNIQUE INDEX "index_users_on_email_address" ON "users" ("email_address") /*application='PetTrackerV4'*/;
CREATE TABLE IF NOT EXISTS "connected_services" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer NOT NULL, "provider" varchar, "uid" varchar, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, CONSTRAINT "fk_rails_006b937ba0"
FOREIGN KEY ("user_id")
  REFERENCES "users" ("id")
);
CREATE INDEX "index_connected_services_on_user_id" ON "connected_services" ("user_id") /*application='PetTrackerV4'*/;
INSERT INTO "schema_migrations" (version) VALUES
('20260119090754'),
('20260118132103'),
('20260107121009'),
('20260106040128'),
('20260105033114'),
('20260103112154'),
('20251231035259'),
('20251230122229'),
('20251230122228');

