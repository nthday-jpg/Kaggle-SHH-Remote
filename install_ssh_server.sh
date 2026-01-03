#!/bin/bash
set -e

PASSWORD="${1:-kaggle}"

export DEBIAN_FRONTEND=noninteractive

echo "Configuring SSH server..."

# Set root password (do not echo password)
echo "root:${PASSWORD}" | sudo chpasswd

# Install Cloudflare Tunnel for Kaggle
echo "Installing cloudflared..."
wget -q https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64
chmod +x cloudflared-linux-amd64
sudo mv cloudflared-linux-amd64 /usr/local/bin/cloudflared
echo "cloudflared installed."

# Install OpenSSH
sudo apt-get update -y
sudo apt-get install -y \
  -o Dpkg::Options::="--force-confdef" \
  -o Dpkg::Options::="--force-confold" \
  openssh-server

# Harden and fix sshd_config safely
SSHD_CONFIG="/etc/ssh/sshd_config"

sudo sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin yes/' $SSHD_CONFIG
sudo sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication yes/' $SSHD_CONFIG
sudo sed -i 's/^#\?PubkeyAuthentication.*/PubkeyAuthentication yes/' $SSHD_CONFIG
sudo sed -i 's/^#\?UsePAM.*/UsePAM yes/' $SSHD_CONFIG
sudo sed -i 's/^#\?ChallengeResponseAuthentication.*/ChallengeResponseAuthentication no/' $SSHD_CONFIG

# Start sshd manually (no systemd in Kaggle)
sudo mkdir -p /var/run/sshd
sudo /usr/sbin/sshd

echo "SSH is running."
