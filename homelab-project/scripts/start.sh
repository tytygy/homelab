#!/bin/bash

# Start all homelab services

set -e

PROJECT_DIR="/home/ty/Documents/First-preoject/homelab-project"
cd "$PROJECT_DIR"

echo "======================================"
echo "Starting Homelab Services"
echo "======================================"
echo ""

# Check if .env exists
if [ ! -f .env ]; then
    echo "ERROR: .env file not found!"
    echo "Run ./scripts/setup.sh first"
    exit 1
fi

# Pull latest images (optional, comment out if you want faster starts)
echo "Pulling Docker images..."
docker compose pull

echo ""
echo "Starting services..."
docker compose up -d

echo ""
echo "======================================"
echo "Services started!"
echo "======================================"
echo ""
echo "Wait 30-60 seconds for all services to initialize."
echo "Then run: ./scripts/status.sh"
echo ""
