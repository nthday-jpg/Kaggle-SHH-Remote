#!/bin/bash
set -e

echo "Starting Cloudflare Tunnel..."
echo "=========================================="
cloudflared tunnel --url tcp://localhost:22
