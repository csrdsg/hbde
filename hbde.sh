#!/usr/bin/env zsh

# Check if Docker is installed
if ! command -v docker &>/dev/null; then
  echo "Docker is not installed. Please install Docker to run this script."
  exit 1
fi

# Name and version of the Docker image
IMAGE_NAME="custom-figlet"
IMAGE_VERSION="1.0"

# Full image name with version
FULL_IMAGE_NAME="${IMAGE_NAME}:${IMAGE_VERSION}"

# Build the Docker image if it doesn't exist
if ! docker image inspect $FULL_IMAGE_NAME &>/dev/null; then
  echo "Building Docker image..."
  docker build -t $FULL_IMAGE_NAME - <<EOF
$(
    cat <<'DOCKERFILE'
# Use a specific version of Alpine Linux
FROM alpine:3.18

# Install figlet
RUN apk add --no-cache figlet

# Set the entrypoint to figlet
ENTRYPOINT ["figlet"]

# Set default command (can be overridden)
CMD ["Hello, World!"]
DOCKERFILE
  )
EOF
fi

# Run the figlet command in a Docker container
docker run --rm $FULL_IMAGE_NAME "Happy Birthday E!"
