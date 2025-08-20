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
