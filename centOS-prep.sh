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

# 4. Install Docker Compose
# Fix: Convert 'Linux' to 'linux' for the URL using tr
OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)

# Download the latest Docker Compose binary
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-${OS}-${ARCH}" -o /usr/local/bin/docker-compose

# Make it executable
sudo chmod +x /usr/local/bin/docker-compose

# Verify installations
echo "Docker version:"
sudo docker --version
echo "Docker Compose version:"
sudo docker-compose --version

# 5. Final Message
echo "----------------------------------------------------------------"
echo "Installation complete."
echo "IMPORTANT: You must log out and log back in for group changes to take effect. Or run newgrp docker"
echo "----------------------------------------------------------------"
