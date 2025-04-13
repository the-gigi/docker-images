# docker-images

Guidance on building Docker images + some images I created and use. But, first let's talk about authentication.

### Using Docker Credential Helpers

You need to authenticate to the container registries where you will push your images (and sometimes even to pull if they
are private registries). Docker credential helpers store registry credentials securely in your system's credential
manager. Follow these instructions to install the credential helper for your OS:
https://github.com/docker/docker-credential-helpers

## Use Multi-stage Builds

Multi-stage builds are essential for creating optimized Docker images for most use case:

- **Smaller image size**: Only necessary artifacts are included in the final image
- **Improved security**: Build tools and dependencies not needed at runtime are excluded
- **Better organization**: Separate building from runtime concerns
- **Reduced attack surface**: Fewer components means fewer potential vulnerabilities

Example:

```dockerfile
# Build stage
FROM golang:1.21 AS builder
WORKDIR /app
COPY . .
RUN go build -o myapp

# Final stage
FROM gcr.io/distroless/base-debian12
COPY --from=builder /app/myapp /
ENTRYPOINT ["/myapp"]
```

There are exceptions when multi-stage builds may not be necessary, such as when building images that need the complete
capabilities of "fat" images (shells, operating system commands, etc).

## Build Multi-platform Images

Building multi-platform images ensures your containers can run on different architectures:

- Use Docker's buildx for multi-platform builds
- Support common architectures like `amd64` and `arm64`
- Test on all target platforms
- Specify platform-specific dependencies when needed

Example:

```bash
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t username/image:latest \
  --push .
```

## Use .dockerignore

Using a `.dockerignore` file excludes unnecessary files and directories from your Docker build context. This reduces the size of the
build context and speeds up the build process. It also helps to avoid including sensitive files or directories that should not be part of the image.

Example `.dockerignore` file:

```
# Git files
.git
.gitignore

# Documentation
README.md

# Build scripts
build.sh

# Temporary files
*.tmp
*.swp
*~

# Logs
*.log
```
 

## Use Distroless as Base Image for Golang Applications

[Distroless](https://github.com/GoogleContainerTools/distroless) images provide several advantages for Golang applications:

- Minimal attack surface with no shell or package manager
- Significantly smaller image size (often <20MB)
- Only contains your application and its runtime dependencies
- Improved security by removing unnecessary components

Example:

```dockerfile
FROM golang:1.23 AS builder
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 go build -o /go/bin/app

FROM gcr.io/distroless/static
COPY --from=builder /go/bin/app /
ENTRYPOINT ["/app"]
```

For other languages, consider using the official Distroless images or other minimal base images.

## Images

Currently, this repo contains a single image:

- [py-kube](py-kube/README.md) - Python environment with Kubernetes tools

## Reference

- [Docker Official Best Practices](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)
- [Google Container Tools](https://github.com/GoogleContainerTools/distroless)
- [Docker Buildx Documentation](https://docs.docker.com/buildx/working-with-buildx/)
- [Multi-platform Docker Builds](https://www.docker.com/blog/multi-platform-docker-builds/)
- [Docker Credential Helpers](https://github.com/docker/docker-credential-helpers)