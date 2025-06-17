-- name: GetUser :one
SELECT * FROM users WHERE id = $1 AND deleted_at IS NULL LIMIT 1;

-- name: GetUserByEmail :one
SELECT * FROM users WHERE email = $1 AND deleted_at IS NULL LIMIT 1;

-- name: ListUsers :many
SELECT * FROM users WHERE deleted_at IS NULL ORDER BY created_at DESC;

-- name: ListUsersByDepartment :many
SELECT * FROM users WHERE department = $1 AND deleted_at IS NULL ORDER BY created_at DESC;

-- name: ListActiveUsers :many
SELECT * FROM users WHERE account_status = 'active' AND deleted_at IS NULL ORDER BY created_at DESC;

-- name: CreateUser :one
INSERT INTO users (
  id, department, first_name, last_name, suffix, email, email_status,
  account_status, user_type, ticket_no, profile_picture, hashed_password,
  smtp_email, smtp_password, created_by
) VALUES (
  $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15
) RETURNING *;

-- name: UpdateUser :one
UPDATE users SET
  department = $2,
  first_name = $3,
  last_name = $4,
  suffix = $5,
  email = $6,
  email_status = $7,
  account_status = $8,
  user_type = $9,
  updated_ticket_no = $10,
  profile_picture = $11,
  smtp_email = $12,
  smtp_password = $13,
  updated_at = now(),
  updated_by = $14
WHERE id = $1 AND deleted_at IS NULL
RETURNING *;

-- name: SoftDeleteUser :exec
UPDATE users SET
  deleted_at = now(),
  deleted_by = $2,
  deleted_ticket_no = $3
WHERE id = $1 AND deleted_at IS NULL;

-- name: UpdateUserPassword :exec
UPDATE users SET
  hashed_password = $2,
  updated_at = now(),
  updated_by = $3
WHERE id = $1 AND deleted_at IS NULL;

-- name: UpdateEmailStatus :exec
UPDATE users SET
  email_status = $2,
  updated_at = now(),
  updated_by = $3
WHERE id = $1 AND deleted_at IS NULL;
