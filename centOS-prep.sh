#!/bin/bash

# 1. Update system and install Docker
sudo yum update -y
sudo yum install -y docker htop

# 2. Start and Enable Docker Service
sudo systemctl start docker
sudo systemctl enable docker

# 3. Create Groups and Add User
# Create the 'evaluation' group if it doesn't exist
if ! getent group evaluation > /dev/null; then
  sudo groupadd evaluation
  echo "Group 'evaluation' created."
else
  echo "Group 'evaluation' already exists."
fi

# Add user to both 'docker' and 'evaluation' groups
# -aG appends the user to the groups without removing them from others
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
echo "----------------------------------------------------------------"
echo "Verifying versions:"
sudo docker --version
sudo docker-compose --version
echo "----------------------------------------------------------------"

# 5. Final Message
echo "Installation and group configuration complete."
echo "Groups assigned: docker"
echo "IMPORTANT: You must log out and log back in for group changes to take effect. Or run `newgrp docker`"
echo "----------------------------------------------------------------"
