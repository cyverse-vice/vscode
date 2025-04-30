# Use specific version tag instead of latest for better reproducibility
FROM lscr.io/linuxserver/code-server:latest

# Add metadata labels
LABEL maintainer="CyVerse.org"
LABEL description="VS Code Server with CUDA, Miniconda, and CyVerse tools"
LABEL version="1.0"

USER root

# Install dependencies for goCommands, text editing, and monitoring
# Note: Combined multiple apt commands to reduce layers
RUN apt update && \
    apt install -y \
        lsb-release \
        apt-transport-https \
        curl \
        libfreetype6-dev \
        pkg-config \
        libx11-dev \
        gcc \
        gettext \
        gnupg \
        less \
        software-properties-common \
        apt-utils \
        glances \
        htop \
        nvtop \
        nano \
        wget \
        sudo \
        pciutils && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# Install GoCommands https://learning.cyverse.org/ds/gocommands/
RUN cd /usr/local/bin/ && \
    GOCMD_VER=$(curl -L -s https://raw.githubusercontent.com/cyverse/gocommands/main/VERSION.txt) && \
    curl -L -s https://github.com/cyverse/gocommands/releases/download/${GOCMD_VER}/gocmd-${GOCMD_VER}-linux-amd64.tar.gz | tar zxvf - && \
    echo "GoCommands ${GOCMD_VER} installed"

# Set up version arguments for easier updates
ARG CUDA_VERSION="12-5"
ARG NVIDIA_DRIVER_VERSION="535"
ARG MINICONDA_VERSION="latest"
ARG GCM_VERSION="2.5.0"

# Handle user setup - base image already has a user with GID 1000
RUN if getent group vscode > /dev/null; then \
      echo "Group vscode already exists"; \
    else \
      groupadd -g 1000 vscode || groupadd vscode; \
    fi && \
    if id -u vscode > /dev/null 2>&1; then \
      echo "User vscode already exists"; \
    else \
      useradd -m -u 1000 -g 1000 -s /bin/bash vscode || useradd -m -g 1000 -s /bin/bash vscode; \
    fi && \
    usermod -aG sudo vscode && \
    echo "vscode ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    echo "# Security note: vscode user has passwordless sudo access" && \
    mkdir -p /home/vscode && \
    chown -R vscode:vscode /home/vscode && \
    chown -R vscode:vscode /config

# Install CUDA toolkit and NVIDIA drivers
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/cuda-keyring_1.1-1_all.deb && \
    dpkg -i cuda-keyring_1.1-1_all.deb && \
    rm cuda-keyring_1.1-1_all.deb && \
    apt update && \
    apt install -y cuda-toolkit-${CUDA_VERSION} nvidia-driver-${NVIDIA_DRIVER_VERSION} && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# Install Miniconda and Mamba
RUN curl -sSLo /tmp/Miniconda3.sh https://repo.anaconda.com/miniconda/Miniconda3-${MINICONDA_VERSION}-Linux-x86_64.sh && \
    bash /tmp/Miniconda3.sh -b -p /opt/conda && \
    rm /tmp/Miniconda3.sh && \
    /opt/conda/bin/conda install -y mamba -n base -c conda-forge && \
    /opt/conda/bin/conda clean -afy && \
    chown -R vscode:vscode /opt/conda && \
    echo "Miniconda and Mamba installed successfully"

# Install Ollama
RUN curl https://ollama.ai/install.sh | sh && \
    echo "Ollama installed successfully"

# Initialize Ollama with models (commented out - uncomment if needed)
#RUN ollama serve & sleep 5 && ollama run mxbai-embed-large && \
#    echo "Ollama initialized with mxbai-embed-large model"

USER vscode

# Install git credential manager
RUN cd /home/vscode && \
    wget https://github.com/git-ecosystem/git-credential-manager/releases/download/v${GCM_VERSION}/gcm-linux_amd64.${GCM_VERSION}.deb && \
    sudo dpkg -i gcm-linux_amd64.${GCM_VERSION}.deb && \
    rm gcm-linux_amd64.${GCM_VERSION}.deb && \
    echo "Git Credential Manager installed"

# Set the environment variable for the credential type
ENV GCM_CREDENTIAL_STORE=cache

# Install VS Code extensions
RUN /app/code-server/bin/code-server --install-extension ms-python.python && \
    /app/code-server/bin/code-server --install-extension vscode-icons-team.vscode-icons && \
    /app/code-server/bin/code-server --install-extension ms-toolsai.jupyter && \
    echo "VS Code extensions installed"

# Expose both ports (8443 for HTTPS, 8080 used in config.yaml)
EXPOSE 8443 8080

# Copy necessary files
COPY entry.sh /bin
COPY config.yaml /config/.config/code-server/config.yaml

# Set up environment variables for Conda
ENV PATH="/opt/conda/bin:$PATH"

# Set working directory
WORKDIR /home/vscode

# Add healthcheck to verify the service is running
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:8080/ || exit 1

ENTRYPOINT ["bash", "/bin/entry.sh"]
