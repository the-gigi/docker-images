#!/bin/bash
set -e

VERSION=0.8
KUBECTL_VERSION=1.32

# Create new builder if it doesn't exist yet
if ! docker buildx ls | grep -q "the-builder"; then
  docker buildx create --name the-builder --driver docker-container
fi
docker buildx use --builder the-builder

# Build with explicit version tags and security options
docker buildx build \
   --platform linux/amd64,linux/arm64 \
   --build-arg KUBECTL_VERSION="$KUBECTL_VERSION" \
   -t g1g1/py-kube:${VERSION} \
   -t g1g1/py-kube:latest \
   --label "org.opencontainers.image.created=$(date -u +"%Y-%m-%dT%H:%M:%SZ")" \
   --label "org.opencontainers.image.revision=$(git rev-parse HEAD)" \
   --label "org.opencontainers.image.licenses=MIT" \
   --push .

echo "Image successfully built and pushed as g1g1/py-kube:${VERSION} and g1g1/py-kube:latest"
