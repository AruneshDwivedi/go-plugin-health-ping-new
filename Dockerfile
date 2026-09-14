FROM golang:1.25

RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY grpc_client.go ./grpc_client.go
COPY grpc_client_ping_test.go ./grpc_client_ping_test.go

# Copy go.mod and go.sum for dependency resolution
RUN go mod download

# Run the specific test that validates the fix
CMD ["sh", "-c", "go test ./... -run TestGRPC_Ping_ChecksServingStatus -v"]
