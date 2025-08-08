# Start from the official Go image
FROM golang:1.23

# Set the working directory
WORKDIR /app

# Copy go mod and sum files
COPY go.mod go.sum ./

# Download dependencies
RUN go mod download

# Copy source code
COPY . .

EXPOSE 8081

# Build the application
RUN go build -o gin-server .

# Command to run the executable
CMD ["./gin-server"]
