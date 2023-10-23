#!/usr/bin/env bash

# Ensure the script exits on any error
set -euo pipefail

# Function to check if a command is available
check_command() {
    if ! command -v "$1" &> /dev/null; then
        echo "$1 is not installed. Please install it and try again."
        exit 1
    fi
}

# Function to safely change directory
safe_cd() {
    if ! cd "$1"; then
        echo "Failed to change directory to $1. Exiting."
        exit 1
    fi
}

cleanup() {
    # Check if a container named "duckhuntjs_container" exists, if so, remove it
    if docker ps -a --filter "name=$CONTAINER_NAME" --format "{{.Names}}" | grep -q "$CONTAINER_NAME"; then
        if ! docker rm -f "$CONTAINER_NAME"; then
            echo "Failed to remove the Docker container. Exiting."
            exit 1
        else
            echo "Successfully removed the Docker container."
        fi
    else
        echo "No Docker container named $CONTAINER_NAME found."
    fi

    # Optionally, you can also remove the Docker image
    # Uncomment the lines below if you want this functionality
    # if docker images "duckhuntjs:latest" -q | grep -q "."; then
    #     if ! docker rmi "duckhuntjs:latest"; then
    #         echo "Failed to remove the Docker image. Exiting."
    #         exit 1
    #     else
    #         echo "Successfully removed the Docker image."
    #     fi
    # else
    #     echo "Docker image duckhuntjs:latest not found."
    # fi
}

# Check for the cleanup argument
if [ "${1:-}" == "cleanup" ]; then
    cleanup
    exit 0
fi

# Check prerequisites
check_command git
check_command docker

# Define repository and Docker details
REPO_DIR="duckHuntJS"
DOCKERFILE="Dockerfile"
CONTAINER_NAME="duckhuntjs_container"

# Clone the repository if it doesn't exist
if [ ! -d "$REPO_DIR" ]; then
    if ! git clone https://github.com/evKoval/duckHuntJS.git "$REPO_DIR"; then
        echo "Failed to clone the repository. Exiting."
        exit 1
    fi
fi

safe_cd "$REPO_DIR"

# Check if Dockerfile exists, if not, create it
if [ ! -f "$DOCKERFILE" ]; then
    cat <<EOL > "$DOCKERFILE"
# Use the official nginx image as a base
FROM nginx:alpine

# Copy the game files to the nginx directory
COPY . /usr/share/nginx/html

# Expose port 80 for the web server
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
EOL
fi

# Build the Docker image
if ! docker build -t duckhuntjs:latest .; then
    echo "Failed to build the Docker image. Exiting."
    exit 1
fi

# Check if a container named "duckhuntjs_container" exists, if so, remove it
if docker ps -a --filter "name=$CONTAINER_NAME" --format "{{.Names}}" | grep -q "$CONTAINER_NAME"; then
    if ! docker rm -f "$CONTAINER_NAME"; then
        echo "Failed to remove the existing Docker container. Exiting."
        exit 1
    fi
fi

# Run the Docker container
if ! docker run -d -p 8181:80 --name "$CONTAINER_NAME" duckhuntjs:latest; then
    echo "Failed to run the Docker container. Exiting."
    exit 1
fi

# Get the IP address of the machine
IP_ADDRESS=$(hostname -I | awk '{print $1}')

echo "Setup complete! You can now access the game by navigating to http://${IP_ADDRESS}:8181 in a web browser."