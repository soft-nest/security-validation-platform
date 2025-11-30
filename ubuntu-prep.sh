#!/bin/bash
set -e

# Docker and Docker Compose Installation Script for Ubuntu
# Based on: https://docs.docker.com/engine/install/ubuntu/

echo "Starting Docker and Docker Compose installation..."

# Check if running as root or with sudo
if [ "$EUID" -ne 0 ]; then 
    echo "Please run as root or with sudo"
    exit 1
fi

echo "Step 1: Uninstalling old/conflicting Docker packages..."
apt-get remove -y docker.io docker-compose docker-compose-v2 docker-doc podman-docker containerd runc 2>/dev/null || true

echo "Step 2: Updating package index..."
apt-get update

echo "Step 3: Installing prerequisites..."
apt-get install -y ca-certificates curl

echo "Step 4: Setting up Docker GPG key..."
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

echo "Step 5: Adding Docker repository..."
. /etc/os-release
cat <<EOF > /etc/apt/sources.list.d/docker.sources
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: ${UBUNTU_CODENAME:-$VERSION_CODENAME}
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

echo "Step 6: Updating package index with Docker repository..."
apt-get update

echo "Step 7: Installing Docker Engine, CLI, and plugins..."
apt-get install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin

echo "Step 8: Starting Docker service..."
systemctl start docker
systemctl enable docker

echo "Step 9: Verifying Docker installation..."
docker --version
docker compose version

echo "Step 10: Testing Docker with hello-world image..."
docker run hello-world

echo ""
echo "✓ Docker and Docker Compose installed successfully!"
echo ""
echo "Optional: To run Docker without sudo, add your user to the docker group:"
echo "  sudo usermod -aG docker $USER"
echo "  newgrp docker"
echo ""
echo "Then log out and back in for the changes to take effect."
