# syntax=docker/dockerfile:1.3

FROM python:3.13-slim@sha256:21e39cf1815802d4c6f89a0d3a166cc67ce58f95b6d1639e68a394c99310d2e5

ARG KUBECTL_VERSION
ARG TARGETARCH

# Install all dependencies in a single layer
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
      vim \
      curl \
      tree \
      dnsutils \
      apt-transport-https \
      ca-certificates \
      netcat-openbsd \
      redis \
      gpg \
      bsdextrautils && \
    # Install kubectl
    mkdir -p -m 755 /etc/apt/keyrings && \
    curl -fsSL "https://pkgs.k8s.io/core:/stable:/v${KUBECTL_VERSION}/deb/Release.key" | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg && \
    chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v${KUBECTL_VERSION}/deb/ /" | tee /etc/apt/sources.list.d/kubernetes.list && \
    chmod 644 /etc/apt/sources.list.d/kubernetes.list && \
    apt-get update -y && \
    apt-get install -y kubectl && \
    # Install mc (MinIO Client) for the correct architecture
    MC_URL="https://dl.min.io/client/mc/release/linux-${TARGETARCH}/mc" && \
    curl -fsSL "$MC_URL" -o /usr/local/bin/mc && \
    chmod +x /usr/local/bin/mc && \
    # Install Python packages
    pip install --no-cache-dir \
      kubernetes \
      httpie \
      ipython && \
    # Create a non-root user
    useradd -m -s /bin/bash -u 1000 kuser && \
    # Clean up to reduce image size
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set up working directory and switch to non-root user
WORKDIR /app
USER kuser

CMD ["bash"]
