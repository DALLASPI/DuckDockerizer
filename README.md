# DuckDockerizer
Dockerize and deploy the classic DuckHunt game with ease. A seamless solution for nostalgic gaming in a modern containerized environment.
Certainly! Here's the updated `README.md` based on the changes to the script and the new repository:

---

# 🦆 DuckHuntJS Dockerizer 🎮

Welcome to the DuckHuntJS Dockerizer! This script allows you to easily set up and run the classic DuckHunt game inside a Docker container. Whether you're a fan of the nostalgic game or just looking to try it out, this tool makes the process seamless and fun!

## 🚀 Quick Start

To download and run the code in one go, use the following command:

```bash
git clone https://github.com/DALLASPI/DuckDockerizer.git && cd DuckDockerizer && chmod +x duckhunt_dockerizer.sh && ./duckhunt_dockerizer.sh
```

## 🛠 Prerequisites

- **Docker**: Ensure you have Docker installed and running on your machine. If not, [install Docker](https://docs.docker.com/get-docker/).
  
- **Git**: The script uses Git to clone the game repository. If you don't have Git installed, you can get it [here](https://git-scm.com/downloads).

- **Node.js & npm**: The game setup requires Node.js and npm. If you don't have them installed, get them [here](https://nodejs.org/).

- **Grunt**: The game uses Grunt for building. Install it globally using:
  ```bash
  npm install -g grunt-cli
  ```

## 📖 Usage

1. **Setup & Run**:
   ```bash
   ./duckhunt_dockerizer.sh
   ```
   This will:
   - ✅ Check if you have the necessary prerequisites.
   - 📦 Clone the DuckHuntJS repository (if it hasn't been cloned already).
   - 🏗 Build the game using Grunt.
   - 🐳 Build a Docker image for the game.
   - 🎮 Run the game inside a Docker container.
   - 🌐 Provide you with a URL to access the game in your browser.

## 🧹 Cleanup

If you wish to completely remove the Docker container and delete the cloned repository, you can use the following one-liner:

```bash
(docker ps -a --filter "name=duckhuntjs_container" --format "{{.Names}}" | grep -q "duckhuntjs_container" && docker rm -f duckhuntjs_container) && [ -d "DuckHunt-JS" ] && rm -rf DuckHunt-JS
```

This command will:

1. Check if the Docker container named `duckhuntjs_container` exists and remove it.
2. Check if the `DuckHunt-JS` directory exists and delete it.

Please note: This action is irreversible. Use with caution.

---

You can add this snippet to the `README.md` under the existing sections to provide users with an option for a complete cleanup.

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

- **Node or Grunt Issues**: Ensure Node.js, npm, and Grunt are correctly installed and available in your PATH.

## 🤝 Contributing

Feel free to fork this repository, make changes, and submit pull requests. Any contributions, whether it's refining the script, adding features, or improving documentation, are always welcome!

## 📜 License

This project is licensed under the MIT License. See the `LICENSE` file for more details.

