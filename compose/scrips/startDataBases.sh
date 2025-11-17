#!/bin/bash

declare -a services=("nbu-db")

for service in "${services[@]}"; do
    echo "Starting $service..."
    docker-compose up -d "$service"
    sleep 10
done

echo "All services have been started with a 10-second delay between each."
