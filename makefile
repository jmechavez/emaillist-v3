# Simple Makefile for Go project

BINARY_NAME=app
BUILD_DIR=bin

.PHONY: build run test clean fmt docker-up docker-down sqlc

# Build the application
build:
	@mkdir -p $(BUILD_DIR)
	go build -o $(BUILD_DIR)/$(BINARY_NAME) ./cmd

# Run the application
run:
	go run ./cmd

# Run tests
test:
	go test ./...

# Clean build artifacts
clean:
	rm -rf $(BUILD_DIR)

# Format code
fmt:
	gofmt -s -w .

# Install dependencies
deps:
	go mod tidy

# Generate templ files
templ:
	templ generate

# Generate sqlc files
sqlc:
	sqlc generate

# Start docker services
docker-up:
	docker-compose up -d

# Stop docker services
docker-down:
	docker-compose down
