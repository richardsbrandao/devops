#cloud-boothook
#!/bin/bash

# Update and Install packages
apt-get -y update
apt-get install -y language-pack-pt

# Install Docker
curl -fsSL get.docker.com -o get-docker.sh
sh get-docker.sh

# Post Docker Instalation
groupadd docker
usermod -aG docker ubuntu

# Reboot to reload configs
reboot