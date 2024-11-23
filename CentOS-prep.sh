#!/bin/bash

# Ensure proper logging and group permissions
sudo yum update -y
sudo yum install -y docker

# Start Docker with explicit logging
sudo systemctl start docker || echo "docker start didn't work"
sudo systemctl enable docker || echo "docker enable didn't work"

# Add user and ensure group membership
sudo usermod -aG docker ec2-user
sudo systemctl restart docker

# Explicit login and group refresh
sudo -u ec2-user newgrp docker

# Verbose Docker and Curl testing
docker version
docker run hello-world || echo "Docker run failed"

# Verbose Curl download
curl -v -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

