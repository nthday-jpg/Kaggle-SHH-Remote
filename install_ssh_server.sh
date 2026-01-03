#!/bin/bash
set -e

PASSWORD="${1:-kaggle}"

export DEBIAN_FRONTEND=noninteractive

echo "Configuring SSH server..."

# Set root password (do not echo password)
echo "root:${PASSWORD}" | sudo chpasswd

# Install bore for SSH tunneling
echo "Installing bore..."
wget -q https://github.com/ekzhang/bore/releases/download/v0.5.1/bore-v0.5.1-x86_64-unknown-linux-musl.tar.gz
tar -xzf bore-v0.5.1-x86_64-unknown-linux-musl.tar.gz
chmod +x bore
sudo mv bore /usr/local/bin/
rm bore-v0.5.1-x86_64-unknown-linux-musl.tar.gz
echo "bore installed."

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
