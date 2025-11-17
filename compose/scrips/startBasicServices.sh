#!/bin/bash

is_service_healthy() {
    local service_name=$1
    local container_name=$(docker-compose ps -q "$service_name")

    if [ -z "$container_name" ]; then
        echo "Container for service $service_name does not exist."
        return 1
    fi

    health_status=$(docker inspect --format '{{json .State.Health.Status}}' "$container_name" 2>/dev/null)
    if [ "$health_status" == '"healthy"' ]; then
        return 0
    else
        return 1
    fi
}



echo "All services have been started successfully."
