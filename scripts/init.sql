-- scripts/init.sql
-- Initial database schema for email service

-- Create custom types
CREATE TYPE "email_status" AS ENUM (
  'pending',
  'approved',
  'rejected',
  'created'
);

CREATE TYPE "user_status" AS ENUM (
  'active',
  'inactive',
  'deleted'
);

CREATE TYPE "user_type" AS ENUM (
  'admin',
  'regular'
);

-- Create users table
CREATE TABLE "users" (
  "id" varchar(255) PRIMARY KEY,
  "department" varchar(255) NOT NULL,
  "first_name" varchar(255) NOT NULL,
  "last_name" varchar(255) NOT NULL,
  "suffix" varchar(255),
  "email" varchar(255) UNIQUE NOT NULL,
  "email_status" email_status NOT NULL,
  "account_status" user_status NOT NULL DEFAULT 'active',
  "user_type" user_type NOT NULL DEFAULT 'regular',
  "ticket_no" varchar(255),
  "updated_ticket_no" varchar(255),
  "deleted_ticket_no" varchar(255),
  "profile_picture" varchar(255),
  "hashed_password" varchar(255) NOT NULL,
  "smtp_email" varchar(255),
  "smtp_password" varchar(255),
  "created_at" timestamp NOT NULL DEFAULT (now()),
  "updated_at" timestamp NOT NULL DEFAULT (now()),
  "deleted_at" timestamp,
  "created_by" varchar(255),
  "updated_by" varchar(255),
  "deleted_by" varchar(255)
);

-- Add table comment
COMMENT ON TABLE "users" IS 'Clean user registration with roles, email statuses, and audit tracking';

-- Create indexes for better performance
CREATE INDEX "idx_users_email" ON "users" ("email");
CREATE INDEX "idx_users_department" ON "users" ("department");
CREATE INDEX "idx_users_email_status" ON "users" ("email_status");
CREATE INDEX "idx_users_account_status" ON "users" ("account_status");
CREATE INDEX "idx_users_created_at" ON "users" ("created_at");

-- Create partial index for active users
CREATE INDEX "idx_users_active" ON "users" ("id") WHERE "account_status" = 'active' AND "deleted_at" IS NULL;
