#!/usr/bin/env bash

# Ensure the script exits on any error
set -euo pipefail

# Define repository and Docker details
REPO_URL="https://github.com/MattSurabian/DuckHunt-JS.git"
REPO_DIR="DuckHunt-JS"
DOCKERFILE="Dockerfile"
CONTAINER_NAME="duckhuntjs_container"

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

# Check prerequisites
check_command git
check_command docker
check_command node
check_command npm

# Clone the repository if it doesn't exist
if [ ! -d "$REPO_DIR" ]; then
    if ! git clone "$REPO_URL" "$REPO_DIR"; then
        echo "Failed to clone the repository. Exiting."
        exit 1
    fi
fi

safe_cd "$REPO_DIR"

# Install Node.js dependencies and build the project
npm install

# Check for grunt-cli and grunt
check_command grunt

# Build the project
grunt build

# Check if Dockerfile exists, if not, create it
if [ ! -f "$DOCKERFILE" ]; then
    cat <<EOL > "$DOCKERFILE"
# Use the official nginx image as a base
FROM nginx:alpine
# Copy the game files to the nginx directory
COPY dist/ /usr/share/nginx/html
# Expose port 80 for the web server
EXPOSE 80
# Start nginx
CMD ["nginx", "-g", "daemon off;"]
EOL
fi

# Build the Docker image
docker build -t duckhuntjs:latest .

# Check if a container named "duckhuntjs_container" exists, if so, remove it
if docker ps -a --filter "name=$CONTAINER_NAME" --format "{{.Names}}" | grep -q "$CONTAINER_NAME"; then
    docker rm -f "$CONTAINER_NAME"
fi

# Run the Docker container
docker run -d -p 8181:80 --name "$CONTAINER_NAME" duckhuntjs:latest

# Get the IP address of the machine
IP_ADDRESS=$(hostname -I | awk '{print $1}')
echo "Setup complete! You can now access the game by navigating to http://${IP_ADDRESS}:8181 in a web browser."
