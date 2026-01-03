#!/bin/bash
set -e

PASSWORD="${1:-kaggle}"

export DEBIAN_FRONTEND=noninteractive

echo "Configuring SSH server..."

# Set root password (do not echo password)
echo "root:${PASSWORD}" | sudo chpasswd

# Install ngrok for Kaggle
echo "Installing ngrok..."
wget -q https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz
tar -xzf ngrok-v3-stable-linux-amd64.tgz -C /kaggle/working/
chmod +x /kaggle/working/ngrok
rm ngrok-v3-stable-linux-amd64.tgz
echo "ngrok installed."

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
