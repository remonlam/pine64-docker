#!/bin/sh

# Update system;
apt-get update

# Install dependencies;
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    gnupg2 \
    curl \
    software-properties-common

# Add Docker’s official GPG key;
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | sudo apt-key add -

# Add repository (note this is ARM64 not ARMHF);
echo "deb [arch=arm64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
     $(lsb_release -cs) stable" | \
     sudo tee /etc/apt/sources.list.d/docker.list

# Update system;
apt-get update

# Install Docker;
apt-get install -y docker-ce

# Enable and start Docker;
systemctl enable docker
systemctl start docker

# Get Docker version
docker version

# Run a test container
docker run --rm hello-world
