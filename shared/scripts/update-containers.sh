#!/bin/bash
docker compose pull | grep "Downloaded newer image" && docker-compose down && docker-compose up -d
