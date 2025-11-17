#!/bin/bash


echo "Starting basic services..."
./startBasicServices.sh


if [ $? -ne 0 ]; then
    echo "Failed to start basic services."
    exit 1
fi


echo "Starting databases..."
./startDataBases.sh


if [ $? -ne 0 ]; then
    echo "Failed to start databases."
    exit 1
fi


echo "Starting microservices..."
./startMicroServices.sh


if [ $? -ne 0 ]; then
    echo "Failed to start microservices."
    exit 1
fi

echo "Starting WebApp..."
./startWebApp.sh
sleep 5

echo "Starting nginx..."
./startNginx.sh



echo "All services started."
