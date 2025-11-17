#!/bin/bash


echo "Starting Nginx service..."


docker-compose up -d nginx


if [ $? -eq 0 ]; then
    echo "Nginx service started successfully."
else
    echo "Failed to start Nginx service."
    exit 1
fi