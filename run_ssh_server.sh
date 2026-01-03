#!/bin/bash
set -e

echo "Starting SSH Tunnel via localhost.run..."
echo "=========================================="
echo "Establishing connection..."
echo ""
ssh -o StrictHostKeyChecking=no -o ServerAliveInterval=60 -R 80:localhost:22 nokey@localhost.run
