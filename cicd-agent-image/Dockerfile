# Base image: Official Atlassian's Ubuntu 20.04 LTS
FROM atlassian/default-image:3

# Set non-interactive mode to prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies (curl, unzip, awscli, pip, and Docker)
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    awscli \
    python3-pip \
    docker.io && \
    rm -rf /var/lib/apt/lists/*

# Install Helm using official script
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 && \
    chmod +x get_helm.sh && ./get_helm.sh && \
    rm -f get_helm.sh

# Install SSM Session Manager Plugin
RUN curl -o /tmp/session-manager-plugin.deb "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" && \
    dpkg -i /tmp/session-manager-plugin.deb && \
    rm -f /tmp/session-manager-plugin.deb
