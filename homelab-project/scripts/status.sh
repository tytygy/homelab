#!/bin/bash

# Show status of all homelab services with access URLs

set -e

PROJECT_DIR="/home/ty/Documents/First-preoject/homelab-project"
cd "$PROJECT_DIR"

# Load VPS_IP from .env
if [ -f .env ]; then
    export $(cat .env | grep -v '^#' | xargs)
fi

VPS_IP=${VPS_IP:-"YOUR_VPS_IP"}

echo "======================================"
echo "Homelab Service Status"
echo "======================================"
echo ""

docker compose ps

echo ""
echo "======================================"
echo "Service Access URLs"
echo "======================================"
echo ""
echo "1. Portainer (Docker UI):     http://${VPS_IP}:9000"
echo "2. Gitea (Git repos):         http://${VPS_IP}:3000"
echo "3. Code Server (VS Code):     http://${VPS_IP}:8443"
echo "4. Navidrome (Music):         http://${VPS_IP}:4533"
echo "5. Jellyfin (Video):          http://${VPS_IP}:8096"
echo "6. Filebrowser (Files):       http://${VPS_IP}:8085"
echo "7. Uptime Kuma (Monitoring):  http://${VPS_IP}:3001"
echo "8. Watchtower (Auto-update):  (runs in background)"
echo ""
echo "======================================"
echo ""
echo "Default credentials:"
echo "- Filebrowser:   admin / admin (change on first login)"
echo "- Code Server:   password from .env file"
echo "- Other services: Set up on first access"
echo ""
