# g1g1/py-kube Docker Image

This repository contains the Docker image `g1g1/py-kube`, which is built for both `amd64` and `arm64` architectures. The
image includes a Python environment with essential tools for Kubernetes management and network utilities.

## Docker Image Details

- **Base Image**: `python:3.13-slim`
- **Architectures Supported**: `amd64`, `arm64`
- **Tools Included**:
    - Vim
    - Curl
    - Tree
    - DNS utilities (`dnsutils`)
    - HTTPS support (`apt-transport-https`, `ca-certificates`)
    - Netcat (`netcat-openbsd`)
    - Redis
    - Kubernetes CLI (`kubectl`)
    - BSD extra utilities (`bsdextrautils`)
    - MinIO Client (`mc`)
    - Python packages:
        - `kubernetes`
        - `httpie`
        - `ipython`

## Security Features

- Runs as non-root user (`kuser`)
- Uses specific package versions to avoid version drift 
- Uses pinned base image with SHA digest for reproducibility
- Built with container image best practices
- Minimal dependencies with --no-install-recommends

## Usage

To pull the image from Docker Hub, use the following command:

```sh
docker pull g1g1/py-kube
```

### Running the Container

This will create a pod called `troubleshooter` and give you a shell with all the tools.

```sh
kubectl run --rm -it --image g1g1/py-kube troubleshooter
```

For local use:

```sh
docker run --rm -it g1g1/py-kube
```

## Building the Image (for Contributors)

The image is automatically built via GitHub Actions on changes to the `py-kube` directory.

If you need to build manually:

1. Clone this repository
2. Make sure Docker Buildx is installed and set up
3. Run:

```sh
cd py-kube
./build.sh
```

Note: You'll need Docker Hub credentials configured for the push to succeed. See the main README.md for information on setting up secure Docker credentials.