#!/bin/bash

# Homelab Setup Script
# Creates necessary directories and prepares the environment

set -e

PROJECT_DIR="/home/ty/Documents/First-preoject/homelab-project"
cd "$PROJECT_DIR"

echo "======================================"
echo "Homelab Setup"
echo "======================================"
echo ""

# Create media directory structure
echo "[1/4] Creating media directories..."
mkdir -p media/music
mkdir -p media/videos
mkdir -p media/files

# Create config directories
echo "[2/4] Creating config directories..."
mkdir -p config/code-server
mkdir -p config/filebrowser
mkdir -p workspace

# Create empty filebrowser database if it doesn't exist
echo "[3/4] Setting up Filebrowser..."
touch config/filebrowser/filebrowser.db

# Check if .env exists
echo "[4/4] Checking environment file..."
if [ ! -f .env ]; then
    echo "Creating .env file from .env.example..."
    cp .env.example .env
    echo ""
    echo "IMPORTANT: Edit .env and set your VPS_IP address!"
    echo "Run: nano .env"
    echo ""
else
    echo ".env file already exists."
fi

echo ""
echo "======================================"
echo "Setup complete!"
echo "======================================"
echo ""
echo "Next steps:"
echo "1. Edit .env file and set your VPS_IP"
echo "   nano .env"
echo ""
echo "2. Start the homelab:"
echo "   ./scripts/start.sh"
echo ""
echo "3. Check status:"
echo "   ./scripts/status.sh"
echo ""
