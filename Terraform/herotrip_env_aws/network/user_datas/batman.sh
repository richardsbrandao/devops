# Update
sudo apt-get update -y

# Install Docker
curl -fsSL get.docker.com -o get-docker.sh
sh get-docker.sh

# Post Docker Instalation
groupadd docker
usermod -aG docker ubuntu