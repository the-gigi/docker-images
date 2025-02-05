# syntax=docker/dockerfile:1.3
ARG BASE_IMAGE
FROM ${BASE_IMAGE}

ARG KUBECTL_VERSION

# Install various tools
RUN apt-get update -y \
 && apt-get install -y vim \
                       curl \
                       tree \
                       dnsutils \
                       apt-transport-https \
                       ca-certificates \
                       netcat-openbsd \
                       redis \
                       gpg \
                       bsdextrautils # for column

# Install kubectl (requires curl)
RUN mkdir -p -m 755 /etc/apt/keyrings \
 && curl -fsSL "https://pkgs.k8s.io/core:/stable:/v${KUBECTL_VERSION}/deb/Release.key" | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg \
 && chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg \
 && echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v${KUBECTL_VERSION}/deb/ /" | tee /etc/apt/sources.list.d/kubernetes.list \
 && chmod 644 /etc/apt/sources.list.d/kubernetes.list

RUN apt-get update -y \
 && apt-get install -y kubectl

RUN pip install kubernetes \
                httpie     \
                ipython

# Install mc (MinIO Client) for the correct architecture (no package manager support)
RUN ARCH=$(dpkg --print-architecture) && \
    if [ "$ARCH" = "amd64" ]; then \
        MC_URL="https://dl.min.io/client/mc/release/linux-amd64/mc"; \
    elif [ "$ARCH" = "arm64" ]; then \
        MC_URL="https://dl.min.io/client/mc/release/linux-arm64/mc"; \
    else \
        echo "Unsupported architecture: $ARCH"; exit 1; \
    fi && \
    curl -fsSL "$MC_URL" -o /usr/local/bin/mc && \
    chmod +x /usr/local/bin/mc

CMD ["bash"]
