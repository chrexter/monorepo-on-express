#!/bin/bash

# Exit on first error
set -e

# Start database and message broker
docker-compose up -d postgres rabbitmq

# Function to start a service
start_service() {
  local service_path=$1
  local service_name=$2
  
  echo "Starting $service_name..."
  cd "$service_path"
  npm run start:dev &
  cd -
}

# Start services in background
start_service "services/user-service" "User Service"
start_service "services/notification-service" "Notification Service"
start_service "api-gateway" "API Gateway"

# Wait for all background processes
wait

echo "All services started successfully!"