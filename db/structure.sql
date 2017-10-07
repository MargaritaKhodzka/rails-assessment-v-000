CREATE TABLE "schema_migrations" ("version" varchar NOT NULL PRIMARY KEY);
CREATE TABLE "ar_internal_metadata" ("key" varchar NOT NULL PRIMARY KEY, "value" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "email" varchar DEFAULT '' NOT NULL, "encrypted_password" varchar DEFAULT '' NOT NULL, "reset_password_token" varchar, "reset_password_sent_at" datetime, "remember_created_at" datetime, "sign_in_count" integer DEFAULT 0 NOT NULL, "current_sign_in_at" datetime, "last_sign_in_at" datetime, "current_sign_in_ip" varchar, "last_sign_in_ip" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "provider" varchar, "uid" varchar, "username" varchar);
CREATE UNIQUE INDEX "index_users_on_email" ON "users" ("email");
CREATE UNIQUE INDEX "index_users_on_reset_password_token" ON "users" ("reset_password_token");
CREATE INDEX "index_users_on_provider" ON "users" ("provider");
CREATE INDEX "index_users_on_uid" ON "users" ("uid");
CREATE TABLE "destination_categories" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "destination_id" integer, "category_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "categories" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "title" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "climate" varchar, "must_have_items" varchar);
CREATE TABLE "destinations" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar, "description" text, "user_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "country" varchar, "best_season_to_visit" varchar, "visited" boolean DEFAULT 'f');
INSERT INTO "schema_migrations" (version) VALUES
('20170909031733'),
('20170911180051'),
('20170911181622'),
('20170912020805'),
('20170912021127'),
('20170912164458'),
('20170912164709'),
('20170913183030'),
('20170913183204'),
('20170913183412'),
('20170913214927'),
('20170913215451'),
('20170913221836'),
('20170913222546'),
('20170914024347'),
('20170914025054'),
('20170914025243'),
('20170914025507'),
('20170914030625');


