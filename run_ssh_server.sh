#!/bin/bash
set -e

echo "Starting SSH Tunnel via Serveo..."
echo "==========================================="
echo "Establishing connection..."
echo ""
echo "Look for the SSH connection command below:"
echo ""
ssh -o StrictHostKeyChecking=no -o ServerAliveInterval=60 -R 22:localhost:22 serveo.net
