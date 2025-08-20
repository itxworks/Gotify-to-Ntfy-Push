# Gotify-to-Ntfy-Push
Push Gotify Messages over ntfy.sh to your (iOS) Devices.

This small Go takes incomming Gotify Messages and forwards them to an ntfs.sh host with the given app name as topic.

### Docker Compose
```
services:
  gotify:
    image: gotify/server
    container_name: gotify
    restart: unless-stopped
    ports:
      - "8080:80"

  gotify-to-ntfy-push:
    image: mp0185/gotify-to-ntfy-push
	container_name: gotify-to-ntfy-push
    restart: unless-stopped
    env_file: .env
    depends_on:
      - gotify
````

`.env`

```
# For Docker internal network (Gotify service name "gotify")
#GOTIFY_URL=ws://gotify:80/stream
# Or if connecting from outside Docker with TLS
# GOTIFY_URL=wss://yourdomain/stream

GOTIFY_URL=wss://gotify.example.com/stream
GOTIFY_CLIENT_TOKEN=yourgotifytoken
#GOTIFY_APPS_DB=apps_db.json

NTFY_URL=https://notify.example.com
NTFY_TOPIC=gotify_alerts
NTFY_AUTH_TOKEN=yourntfytoken
NTFY_PRIORITY=5

NTFY_SPLIT_TOPICS=true
NTFY_SYNC_INTERVAL=300
NTFY_DEBUG=true

TZ=Europe/Vienna
```
## Debug Log Example

```bash
gotify  | Starting Gotify version 2.6.3@2025-04-27-09:10:38
gotify  | Started listening for plain connection on tcp [::]:80
gotify-to-ntfy-push  | 2025/08/20 14:58:55 [DEBUG] Using SplitTopics: true
gotify-to-ntfy-push  | 2025/08/20 14:58:55 [DEBUG] Using auth token
gotify-to-ntfy-push  | 2025/08/20 14:58:55 Starting forwarder: Gotify=ws://gotify/stream -> ntfy=http://ntfy/gotify_alerts
gotify               | 2025-08-20T14:58:55+02:00 | 200 |    2.142732ms |     172.30.0.13 | GET      "/application"
gotify-to-ntfy-push  | 2025/08/20 14:58:55 Got 4 apps:
gotify-to-ntfy-push  | 2025/08/20 14:58:55 - ID=1 Name=Proxmox Description=proxmox Token=********
gotify-to-ntfy-push  | 2025/08/20 14:58:55 - ID=2 Name=TueNas Description=TrueNas Token=********
gotify-to-ntfy-push  | 2025/08/20 14:58:55 - ID=3 Name=SSH Description=ssh login Token=********
gotify-to-ntfy-push  | 2025/08/20 14:58:55 - ID=4 Name=uptime-kuma Description=lan Token=********
gotify-to-ntfy-push  | 2025/08/20 14:58:55 [DEBUG] Using auth token
gotify-to-ntfy-push  | 2025/08/20 14:58:55 Starting forwarder: Gotify=ws://gotify/stream -> ntfy=http://ntfy/gotify_alerts
gotify-to-ntfy-push  | 2025/08/20 14:58:55 Got 4 apps:
gotify-to-ntfy-push  | 2025/08/20 14:58:55 - ID=1 Name=Proxmox Description=proxmox Token=********
gotify-to-ntfy-push  | 2025/08/20 14:58:55 - ID=2 Name=TueNas Description=TrueNas Token=********
gotify-to-ntfy-push  | 2025/08/20 14:58:55 - ID=3 Name=SSH Description=ssh login Token=********
gotify-to-ntfy-push  | 2025/08/20 14:58:55 - ID=4 Name=uptime-kuma Description=lan Token=********
gotify-to-ntfy-push  | 2025/08/20 14:58:55 [NTFY] Sent startup message with 4 apps
gotify               | 2025-08-20T14:58:55+02:00 | 200 |    1.268852ms |     172.30.0.13 | GET      "/application"
gotify-to-ntfy-push  | 2025/08/20 14:58:55 Connected to Gotify stream
gotify-to-ntfy-push  | 2025/08/20 14:58:55 [NTFY] Sent startup message with 4 apps
gotify-to-ntfy-push  | 2025/08/20 14:58:55 Connected to Gotify stream
gotify               | 2025-08-20T14:58:55+02:00 | 200 |    3.831551ms |     172.30.0.13 | GET      "/stream"
gotify               | 2025-08-20T14:58:55+02:00 | 200 |    2.156114ms |     172.30.0.13 | GET      "/application"
gotify-to-ntfy-push  | 2025/08/20 14:58:55 [DEBUG] [SYNC] Topic validated (no-op): proxmox
gotify-to-ntfy-push  | 2025/08/20 14:58:55 [DEBUG] [SYNC] Topic validated (no-op): proxmox
gotify-to-ntfy-push  | 2025/08/20 14:58:55 [DEBUG] [SYNC] Topic ready: proxmox
gotify-to-ntfy-push  | 2025/08/20 14:58:55 [DEBUG] [SYNC] Topic validated (no-op): tuenas
gotify-to-ntfy-push  | 2025/08/20 14:58:55 [DEBUG] [SYNC] Topic ready: tuenas
gotify-to-ntfy-push  | 2025/08/20 14:58:55 [DEBUG] [SYNC] Topic validated (no-op): ssh
gotify-to-ntfy-push  | 2025/08/20 14:58:55 [DEBUG] [SYNC] Topic ready: ssh
gotify-to-ntfy-push  | 2025/08/20 14:58:55 [DEBUG] [SYNC] Topic validated (no-op): uptime-kuma
gotify-to-ntfy-push  | 2025/08/20 14:58:55 [DEBUG] [SYNC] Topic ready: uptime-kuma
gotify-to-ntfy-push  | 2025/08/20 14:58:55 [DEBUG] [SYNC] Topic ready: proxmox
gotify-to-ntfy-push  | 2025/08/20 14:58:55 [DEBUG] [SYNC] Topic validated (no-op): tuenas
gotify-to-ntfy-push  | 2025/08/20 14:58:55 [DEBUG] [SYNC] Topic ready: tuenas
gotify-to-ntfy-push  | 2025/08/20 14:58:55 [DEBUG] [SYNC] Topic validated (no-op): ssh
gotify-to-ntfy-push  | 2025/08/20 14:58:55 [DEBUG] [SYNC] Topic ready: ssh
gotify-to-ntfy-push  | 2025/08/20 14:58:55 [DEBUG] [SYNC] Topic validated (no-op): uptime-kuma
gotify-to-ntfy-push  | 2025/08/20 14:58:55 [DEBUG] [SYNC] Topic ready: uptime-kuma
````
