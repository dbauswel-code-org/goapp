# Stage 1: Build the Go binary
FROM golang:1.24 AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy go.mod and go.sum files and download dependencies
COPY go.mod go.sum ./
RUN go mod download

# Copy the rest of the source code
COPY . .

# Build the Go app
RUN CGO_ENABLED=0 GOOS=linux go build -o server .

# Stage 2: Create a small runtime image
FROM alpine:latest

# Create a non-root user (optional but recommended)
RUN adduser -D gouser

WORKDIR /app

# Copy the binary from the builder stage
COPY --from=builder /app/server .

# Use a non-root user
USER gouser

# Expose the port your app listens on
EXPOSE 1323

# Run the binary
CMD ["./server"]
