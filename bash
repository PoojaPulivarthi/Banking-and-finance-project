#!/bin/bash

APP_NAME="banking-app"
BACKUP_DIR="/opt/backups"
TIMESTAMP=$(date +"%F-%T")

echo "Starting backup and deployment for $APP_NAME"

# Create backup
mkdir -p "$BACKUP_DIR"
docker container stop $APP_NAME
docker commit $APP_NAME "$APP_NAME-backup:$TIMESTAMP"
docker save "$APP_NAME-backup:$TIMESTAMP" > "$BACKUP_DIR/$APP_NAME-$TIMESTAMP.tar"

echo "Backup saved to $BACKUP_DIR/$APP_NAME-$TIMESTAMP.tar"

# Pull new image and restart
docker pull myregistry.com/$APP_NAME:latest
docker rm $APP_NAME
docker run -d --name $APP_NAME -p 80:80 myregistry.com/$APP_NAME:latest

echo "Deployment complete!"
