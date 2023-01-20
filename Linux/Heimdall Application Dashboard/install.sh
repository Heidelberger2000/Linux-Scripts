#!/bin/bash

# https://heimdall.site/

apt install docker.io docker-compose -y 
mkdir /heimdall
cd /heimdall
mkdir /heimdall-data
echo "
version: "2.1"
services:
  heimdall:
    image: linuxserver/heimdall
    container_name: heimdall
    volumes:
      - /heimdall-data:/config
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/London
    ports:
      - 80:80
      - 443:443
    restart: unless-stopped" > docker-compose.yml

docker-compose up -d
