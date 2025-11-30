#!/bin/bash

# 1. Update system and install Docker
sudo yum update -y
sudo yum install -y docker htop

# 2. Start and Enable Docker Service
sudo systemctl start docker
sudo systemctl enable docker

# 3. Add user to the docker group
# This allows running docker commands without 'sudo'
sudo usermod -aG docker ec2-user

# 4. Install Docker Compose v2 as a CLI plugin
OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)

# Create the CLI plugins directory
sudo mkdir -p /usr/local/lib/docker/cli-plugins

# Download Docker Compose v2 plugin
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-${OS}-${ARCH}" -o /usr/local/lib/docker/cli-plugins/docker-compose

# Make it executable
sudo chmod +x /usr/local/lib/docker/cli-plugins/docker-compose

# 5. Install Docker Buildx plugin
# Download the latest buildx binary
sudo curl -L "https://github.com/docker/buildx/releases/download/v0.17.1/buildx-v0.17.1.${OS}-${ARCH}" -o /usr/local/lib/docker/cli-plugins/docker-buildx

# Make it executable
sudo chmod +x /usr/local/lib/docker/cli-plugins/docker-buildx

# 6. Verify installations
echo "Docker version:"
docker --version
echo ""
echo "Docker Compose version:"
docker compose version
echo ""
echo "Docker Buildx version:"
docker buildx version

# 7. Final Message
echo "----------------------------------------------------------------"
echo "Installation complete."
echo "IMPORTANT: You must log out and log back in for group changes to take effect. Or run: newgrp docker"
echo "Note: Use 'docker compose' (not 'docker-compose') for Compose v2"
echo "----------------------------------------------------------------"
