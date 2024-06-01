BASE_IMAGE=python:3.12-slim
VERSION=0.5
KUBECTL_VERSION=1.30

echo $DOCKERHUB_PASSWORD | docker login -u $DOCKERHUB_USERNAME --password-stdin

# Create new builder if it doesn't exist yet
if ! docker buildx ls | grep -q "the-builder"; then
  docker buildx create --name the-builder --driver docker-container
fi
docker  buildx use --builder the-builder

docker buildx build \
   --platform linux/amd64,linux/arm64 \
   --build-arg BASE_IMAGE="$BASE_IMAGE" \
   --build-arg KUBECTL_VERSION="$KUBECTL_VERSION" \
   -t g1g1/py-kube:${VERSION} \
   -t g1g1/py-kube:latest \
   --push .
