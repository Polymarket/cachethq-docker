#!/bin/bash

ECR_REGISTRY=""
STAGING_ECR_REPOSITORY="clob-staging"
PROD_ECR_REPOSITORY="clob-prod"
IMAGE_TAG="2.3.20"

STAGING_IMAGE="$ECR_REGISTRY/$STAGING_ECR_REPOSITORY:cachethq-docker_$IMAGE_TAG"
PROD_IMAGE="$ECR_REGISTRY/$PROD_ECR_REPOSITORY:cachethq-docker_$IMAGE_TAG"

aws ecr get-login-password | docker login --username AWS --password-stdin $ECR_REGISTRY

export DOCKER_DEFAULT_PLATFORM=linux/amd64

docker build -t $STAGING_IMAGE .
docker push $STAGING_IMAGE

docker build -t $PROD_IMAGE .
docker push $PROD_IMAGE

echo $STAGING_IMAGE
echo $PROD_IMAGE