# g1g1/py-kube Docker Image

This repository contains the Docker image `g1g1/py-kube`, which is built for both `amd64` and `arm64` architectures. The image includes a Python environment with essential tools for Kubernetes management and network utilities.

## Docker Image Details

- **Base Image**: `python:3.12-slim`
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
  - Python packages:
    - `kubernetes`
    - `httpie`
    - `ipython`

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

## Building the Image (for Gigi only)

Make sure these environment variables are defined:
```sh
export DOCKERHUB_USERNAME=<your-dockerhub-username>
export DOCKERHUB_PASSWORD=<your-dockerhub-password>
```

Run:
```sh
./build.sh
```
