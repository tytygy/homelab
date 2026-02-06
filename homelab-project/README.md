# Simple Homelab on VPS

A clean, straightforward homelab setup for learning Docker and self-hosting services. No reverse proxy, no SSL complexity — just direct port access to services.

## Services Included

| Service | Port | Description |
|---------|------|-------------|
| **Portainer** | 9000 | Web UI for managing Docker containers |
| **Gitea** | 3000 | Self-hosted Git service (like GitHub) |
| **Code Server** | 8443 | VS Code in your browser |
| **Navidrome** | 4533 | Music streaming server (Subsonic API compatible) |
| **Jellyfin** | 8096 | Media server for videos |
| **Filebrowser** | 8085 | Upload/download files via web interface |
| **Uptime Kuma** | 3001 | Monitor all your services |
| **Watchtower** | — | Auto-updates Docker containers (background service) |

## Quick Start

### 1. Initial Setup

```bash
# Make scripts executable
chmod +x scripts/*.sh

# Run setup (creates directories)
./scripts/setup.sh

# Edit .env file and set your VPS IP address
nano .env
```

### 2. Start Services

```bash
./scripts/start.sh
```

Wait 30-60 seconds for all services to initialize.

### 3. Check Status

```bash
./scripts/status.sh
```

This shows which services are running and their access URLs.

## Access Your Services

Replace `YOUR_VPS_IP` with your actual VPS IP address:

- Portainer: `http://YOUR_VPS_IP:9000`
- Gitea: `http://YOUR_VPS_IP:3000`
- Code Server: `http://YOUR_VPS_IP:8443`
- Navidrome: `http://YOUR_VPS_IP:4533`
- Jellyfin: `http://YOUR_VPS_IP:8096`
- Filebrowser: `http://YOUR_VPS_IP:8085`
- Uptime Kuma: `http://YOUR_VPS_IP:3001`

## Default Credentials

- **Filebrowser**: `admin` / `admin` (change on first login)
- **Code Server**: Password set in `.env` file (default: `changeme123`)
- **Other services**: Create account on first access

## Uploading Music and Media

### Method 1: Using Filebrowser (Easiest)

1. Go to `http://YOUR_VPS_IP:8085`
2. Login with `admin` / `admin`
3. Navigate to the appropriate folder:
   - `music/` for Navidrome
   - `videos/` for Jellyfin
   - `files/` for general storage
4. Click upload button and select files

### Method 2: Using SCP/SFTP

```bash
# Upload music
scp -r /local/music/* user@YOUR_VPS_IP:/home/ty/Documents/First-preoject/homelab-project/media/music/

# Upload videos
scp -r /local/videos/* user@YOUR_VPS_IP:/home/ty/Documents/First-preoject/homelab-project/media/videos/
```

After uploading music, Navidrome will automatically scan and add it (scans every hour, or trigger manually in settings).

## Directory Structure

```
homelab-project/
├── docker-compose.yml          # Main configuration
├── .env                        # Your settings (IP, passwords)
├── .env.example                # Template
├── README.md                   # This file
├── scripts/
│   ├── setup.sh               # Initial setup
│   ├── start.sh               # Start all services
│   ├── stop.sh                # Stop all services
│   └── status.sh              # Show status and URLs
├── media/
│   ├── music/                 # Music files for Navidrome
│   ├── videos/                # Video files for Jellyfin
│   └── files/                 # General file storage
├── workspace/                 # Code Server projects
└── config/                    # Service configurations
```

## Common Tasks

### Stop All Services
```bash
./scripts/stop.sh
```

### Restart All Services
```bash
./scripts/stop.sh
./scripts/start.sh
```

### View Logs
```bash
# All services
docker compose logs

# Specific service
docker compose logs navidrome

# Follow logs in real-time
docker compose logs -f
```

### Update Services

Watchtower automatically checks for updates daily and updates containers. To manually update:

```bash
docker compose pull
docker compose up -d
```

## Firewall Configuration

Make sure these ports are open on your VPS firewall:

```bash
# Using ufw (Ubuntu)
sudo ufw allow 9000/tcp   # Portainer
sudo ufw allow 3000/tcp   # Gitea
sudo ufw allow 8443/tcp   # Code Server
sudo ufw allow 4533/tcp   # Navidrome
sudo ufw allow 8096/tcp   # Jellyfin
sudo ufw allow 8085/tcp   # Filebrowser
sudo ufw allow 3001/tcp   # Uptime Kuma
sudo ufw allow 2222/tcp   # Gitea SSH (optional)
```

## Setting Up Monitoring

1. Access Uptime Kuma at `http://YOUR_VPS_IP:3001`
2. Create admin account
3. Add monitors for each service:
   - Type: HTTP(s)
   - URL: `http://YOUR_VPS_IP:PORT`
   - Heartbeat interval: 60 seconds

Example monitors to add:
- Portainer: `http://YOUR_VPS_IP:9000`
- Gitea: `http://YOUR_VPS_IP:3000`
- Navidrome: `http://YOUR_VPS_IP:4533`
- Jellyfin: `http://YOUR_VPS_IP:8096`
- Filebrowser: `http://YOUR_VPS_IP:8085`

## Troubleshooting

### Service won't start
```bash
# Check logs
docker compose logs [service-name]

# Example
docker compose logs navidrome
```

### Port already in use
```bash
# Check what's using the port
sudo lsof -i :9000

# Or use netstat
sudo netstat -tulpn | grep 9000
```

### Reset a service
```bash
# Stop service
docker compose stop navidrome

# Remove container
docker compose rm navidrome

# Start again
docker compose up -d navidrome
```

### Clear all data and start fresh
```bash
# WARNING: This deletes everything!
./scripts/stop.sh
docker compose down -v
rm -rf media/* config/* workspace/*
./scripts/setup.sh
./scripts/start.sh
```

## Backup Important Data

Backup these directories regularly:

```bash
# Backup script example
tar -czf homelab-backup-$(date +%Y%m%d).tar.gz \
  media/ \
  config/ \
  workspace/ \
  .env
```

## Notes

- All services run on HTTP (no HTTPS/SSL) — this is for simplicity and learning
- Services are accessible directly via IP:PORT — no reverse proxy
- Watchtower keeps containers updated automatically
- Data persists in Docker volumes and local directories
- All services are on the same Docker network and can communicate

## Next Steps

1. Set up Uptime Kuma to monitor all services
2. Upload some music and configure Navidrome
3. Upload videos and set up Jellyfin libraries
4. Create Git repositories in Gitea
5. Use Code Server to edit projects
6. Explore Portainer to learn Docker management

## Support

This is a learning-focused setup. Experiment, break things, and rebuild. That's how you learn!

Common resources:
- [Portainer Docs](https://docs.portainer.io/)
- [Gitea Docs](https://docs.gitea.io/)
- [Navidrome Docs](https://www.navidrome.org/docs/)
- [Jellyfin Docs](https://jellyfin.org/docs/)
