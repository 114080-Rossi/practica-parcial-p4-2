#!/bin/bash

declare -a services=("nbu-be")

for service in "${services[@]}"; do
    echo "Starting $service..."
    docker-compose up -d $service
    sleep 15
done

echo "All backend services have been started with a 15-second delay between each."
