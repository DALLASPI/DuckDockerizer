# DuckDockerizer
Dockerize and deploy the classic DuckHunt game with ease. A seamless solution for nostalgic gaming in a modern containerized environment.

# 🦆 DuckHuntJS Dockerizer 🎮

Welcome to the DuckHuntJS Dockerizer! This script allows you to easily set up and run the classic DuckHunt game inside a Docker container. Whether you're a fan of the nostalgic game or just looking to try it out, this tool makes the process seamless and fun!

## 🛠 Prerequisites

- **Docker**: Ensure you have Docker installed and running on your machine. If not, [install Docker](https://docs.docker.com/get-docker/).
  
- **Git**: The script uses Git to clone the game repository. If you don't have Git installed, you can get it [here](https://git-scm.com/downloads).

## 🚀 Usage

1. **Setup & Run**:
   ```bash
   ./duckhunt_dockerizer.sh
   ```
   This will:
   - ✅ Check if you have the necessary prerequisites.
   - 📦 Clone the DuckHuntJS repository (if it hasn't been cloned already).
   - 🏗 Build a Docker image for the game.
   - 🎮 Run the game inside a Docker container.
   - 🌐 Provide you with a URL to access the game in your browser.

2. **Cleanup**:
   If you wish to remove the Docker container (and optionally the image):
   ```bash
   ./duckhunt_dockerizer.sh cleanup
   ```

## ❗ Troubleshooting

- **Permission Denied**: If you encounter a permission denied error when running the script, make it executable with:
  ```bash
  chmod +x duckhunt_dockerizer.sh
  ```

- **Docker Issues**: Ensure Docker is running. If you face issues related to Docker, refer to the [official Docker documentation](https://docs.docker.com/).

## 🤝 Contributing

Feel free to fork this repository, make changes, and submit pull requests. Any contributions, whether it's refining the script, adding features, or improving documentation, are always welcome!

## 📜 License

This project is open-source. Feel free to use, modify, and distribute it as you see fit.
