package db

import (
	"context"
	"database/sql"
	"testing"

	"github.com/jmechavez/emaillist-v3/internal/adapters/secondary/persistence/postgres"
	"github.com/stretchr/testify/require"
)

func TestCreateUser(t *testing.T) {
	args := CreateUserParams{
		ID:             "test-user-123",
		Department:     "Engineering",
		FirstName:      "John",
		LastName:       "Doe",
		Suffix:         sql.NullString{String: "Jr.", Valid: true}, // or sql.NullString{Valid: false} for null
		Email:          "john.doe@example.com",
		EmailStatus:    postgres.EmailStatusPending, // Using the imported package
		AccountStatus:  postgres.UserStatusActive,   // Using the imported package
		UserType:       postgres.UserTypeAdmin,      // Adjust based on your enum values
		TicketNo:       sql.NullString{String: "TICKET-001", Valid: true},
		ProfilePicture: sql.NullString{Valid: false}, // null value
		HashedPassword: "$2a$10$hashedpasswordexample",
		SmtpEmail:      sql.NullString{String: "smtp@example.com", Valid: true},
		SmtpPassword:   sql.NullString{String: "smtppassword", Valid: true},
		CreatedBy:      sql.NullString{String: "admin", Valid: true},
	}

	user, err := testQueries.CreateUser(context.Background(), args)
	require.NoError(t, err)
	require.NotEmpty(t, user)

	// Additional assertions to verify the created user
	require.Equal(t, args.ID, user.ID)
	require.Equal(t, args.Department, user.Department)
	require.Equal(t, args.FirstName, user.FirstName)
	require.Equal(t, args.LastName, user.LastName)
	require.Equal(t, args.Email, user.Email)
	require.Equal(t, args.EmailStatus, user.EmailStatus)
	require.Equal(t, args.AccountStatus, user.AccountStatus)
	require.Equal(t, args.UserType, user.UserType)
}
