#!/bin/bash
set -e

echo "Starting SSH Tunnel via bore..."
echo "==========================================="
echo "Connecting to bore.pub..."
echo ""
echo "Once connected, use this command from your local machine:"
echo "ssh root@bore.pub -p <PORT_SHOWN_BELOW>"
echo ""
bore local 22 --to bore.pub
