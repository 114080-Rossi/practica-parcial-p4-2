#!/bin/bash

echo "Starting WebApp..."

docker-compose up -d webapp

if [ $? -eq 0 ]; then
    echo "WebApp service started."
else
    echo "Failed to start WebApp service."
    exit 1
fi
