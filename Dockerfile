# syntax=docker/dockerfile:1

ARG GO_VERSION=1.23
ARG ALPINE_VERSION=3.22.1

############################
# Builder stage
############################
FROM golang:${GO_VERSION}-alpine AS builder

WORKDIR /app

# Install git for go modules (if needed)
RUN apk add --no-cache ca-certificates tzdata git

# Copy Go modules files first for caching
COPY go.mod go.sum ./
RUN go mod download

COPY main.go .
RUN go build -o forwarder main.go

# --- Final minimal image ---
FROM alpine:${ALPINE_VERSION}

WORKDIR /app

RUN apk add --no-cache ca-certificates tzdata git

COPY --from=builder /app/forwarder /forwarder

# Run binary (loads .env automatically)
CMD ["/forwarder"]

