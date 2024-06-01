# syntax=docker/dockerfile:1.3
ARG BASE_IMAGE
FROM ${BASE_IMAGE}

ARG KUBECTL_VERSION

# Install various tools
RUN apt-get update -y \
 && apt-get install -y vim \
                       curl \
                       dnsutils \
                       apt-transport-https \
                       ca-certificates \
                       netcat-openbsd \
                       redis \
                       gpg

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

CMD bash
