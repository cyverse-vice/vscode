FROM lscr.io/linuxserver/code-server:4.96.4

USER root

# Install a few dependencies for goCommands, text editing, and monitoring instances
RUN apt update && \
    apt install -y lsb-release apt-transport-https curl libfreetype6-dev pkg-config libx11-dev gcc gettext gnupg less software-properties-common apt-utils glances htop nano wget

# Install GoCommands https://learning.cyverse.org/ds/gocommands/ 
RUN cd /usr/local/bin/ && \
    GOCMD_VER=$(curl -L -s https://raw.githubusercontent.com/cyverse/gocommands/main/VERSION.txt); \
    curl -L -s https://github.com/cyverse/gocommands/releases/download/${GOCMD_VER}/gocmd-${GOCMD_VER}-linux-amd64.tar.gz | tar zxvf -

# Add sudo 
RUN apt update && \
    apt install -y sudo && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# Create user vscode with specific UID and GID
RUN groupadd -g 1000 vscode && \
    useradd -m -u 1000 -g 1000 -s /bin/bash vscode && \
    usermod -aG sudo vscode && \
    echo "vscode ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Install cuda toolkit and nvidia drivers
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/cuda-keyring_1.1-1_all.deb && \
    dpkg -i cuda-keyring_1.1-1_all.deb && \
    apt update && \
    apt install -y cuda-toolkit-12-5 nvidia-driver-535 -y

# Set ownership for home directory
RUN chown -R vscode:vscode /home/vscode && \
    chown -R vscode:vscode /config

# Install Miniconda and Mamba
RUN curl -sSLo /tmp/Miniconda3.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    bash /tmp/Miniconda3.sh -b -p /opt/conda && \
    rm /tmp/Miniconda3.sh && \
    /opt/conda/bin/conda install -y mamba -n base -c conda-forge && \
    /opt/conda/bin/conda clean -afy && \
    chown -R vscode:vscode /opt/conda

# Install Ollama and dependecies
RUN apt install pciutils -y && \
curl https://ollama.ai/install.sh | sh

#RUN ollama serve & sleep 5 && ollama run mxbai-embed-large

USER vscode

# install git credential manager
RUN cd /home/vscode && \
    wget https://github.com/git-ecosystem/git-credential-manager/releases/download/v2.5.0/gcm-linux_amd64.2.5.0.deb && \
    sudo dpkg -i gcm-linux_amd64.2.5.0.deb && \
    rm gcm-linux_amd64.2.5.0.deb

# set the ENV for the credential type
ENV GCM_CREDENTIAL_STORE=cache

EXPOSE 8443

COPY entry.sh /bin

# Set up environment variables for Conda
ENV PATH="/opt/conda/bin:$PATH"

WORKDIR /home/vscode

ENTRYPOINT ["bash", "/bin/entry.sh"]
