#!/bin/bash

# Stop all homelab services

set -e

PROJECT_DIR="/home/ty/Documents/First-preoject/homelab-project"
cd "$PROJECT_DIR"

echo "======================================"
echo "Stopping Homelab Services"
echo "======================================"
echo ""

docker compose down

echo ""
echo "All services stopped."
echo ""
