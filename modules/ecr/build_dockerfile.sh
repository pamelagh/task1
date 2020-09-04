#!/bin/bash

# This is the order of arguments
region=$1
repository_name=$2
aws_ecr_repository_url=$3

echo "Building $aws_ecr_repository_url_with_tag from Dockerfile"

# Retrieve an authentication token and authenticate your Docker client to your registry
aws ecr get-login-password --region $region | docker login --username AWS --password-stdin $aws_ecr_repository_url

# Build image
docker build -t $aws_ecr_repository_url .

# Tag image to push the image to repository
docker tag $repository_name:latest $aws_ecr_repository_url:latest

# Push image
docker push $aws_ecr_repository_url:latest
