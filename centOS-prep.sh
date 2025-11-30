#!/bin/bash

# Update system packages
sudo yum update -y

# Install Docker
sudo yum install -y docker

# Start Docker service
sudo systemctl start docker

# Enable Docker to start on boot
sudo systemctl enable docker

# Add current user to docker group (to run docker without sudo)
sudo usermod -aG docker $USER

# Install Docker Compose plugin
DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
mkdir -p $DOCKER_CONFIG/cli-plugins
curl -SL https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose
chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose

# Verify installations
docker --version
docker compose version
