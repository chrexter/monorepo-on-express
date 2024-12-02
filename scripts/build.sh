#!/bin/bash

# Exit on first error
set -e

# Build common utilities
echo "Building common utilities..."
cd common
npm run build

# Build each service
echo "Building services..."
for service in ../services/*; do
  if [ -d "$service" ]; then
    cd "$service"
    npm run build
    cd -
  fi
done

# Build API Gateway
echo "Building API Gateway..."
cd ../api-gateway
npm run build

echo "All services built successfully!"