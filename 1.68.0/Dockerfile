FROM gitpod/openvscode-server:1.68.0

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.name="CyVerse VSCode" \
    org.label-schema.description="Built from GitPod Open VSCode, additional depends for CyVerse K8s workbench" \
    org.label-schema.url="https://cyverse.org" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="e.g. https://github.com/cyverse-vice/vscode" \
    org.label-schema.vendor="CyVerse" \
    org.label-schema.version=$VERSION \
    org.label-schema.schema-version="1.0.0"

USER root

ARG DEBIAN_FRONTEND=noninteractive

# Install a few dependencies for iCommands, text editing, and monitoring instances
RUN apt-get update && \
    apt-get install -y lsb-release apt-transport-https curl gnupg2 libfuse2 gettext gcc less nodejs software-properties-common apt-utils glances htop nano  && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    apt-get install -y vim-nox && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    apt-get install -y emacs-nox && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN wget -qO - https://packages.irods.org/irods-signing-key.asc | apt-key add - && \
    echo "deb [arch=amd64] https://packages.irods.org/apt/ $(lsb_release -sc) main" >> /etc/apt/sources.list.d/renci-irods.list && \
    apt-get update && \
    apt install -y irods-icommands 
RUN wget -q -c \
    http://security.ubuntu.com/ubuntu/pool/main/p/python-urllib3/python-urllib3_1.22-1ubuntu0.18.04.2_all.deb \
    http://security.ubuntu.com/ubuntu/pool/main/r/requests/python-requests_2.18.4-2ubuntu0.1_all.deb \
    http://security.ubuntu.com/ubuntu/pool/main/o/openssl1.0/libssl1.0.0_1.0.2n-1ubuntu5.10_amd64.deb
RUN apt install -y \
    ./python-urllib3_1.22-1ubuntu0.18.04.2_all.deb \
    ./python-requests_2.18.4-2ubuntu0.1_all.deb \
    ./libssl1.0.0_1.0.2n-1ubuntu5.10_amd64.deb && \
    rm -rf \
    ./python-urllib3_1.22-1ubuntu0.18.04.2_all.deb \
    ./python-requests_2.18.4-2ubuntu0.1_all.deb \
    ./libssl1.0.0_1.0.2n-1ubuntu5.10_amd64.deb && \
    apt install -y irods-icommands && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Go
RUN wget -q -c https://dl.google.com/go/go1.17.6.linux-amd64.tar.gz -O - | tar -xz -C /usr/local
ENV PATH=$PATH:/usr/local/go/bin 

# Install Rust
RUN apt-get update && \
    apt-get install -y cargo rustc

# Install CyberDuck CLI
RUN echo "deb https://s3.amazonaws.com/repo.deb.cyberduck.io stable main" | tee /etc/apt/sources.list.d/cyberduck.list > /dev/null && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FE7097963FEFBE72 && \
    apt-get update && \
    apt-get install duck

# Install MiniConda and Tini
ENV TZ America/Phoenix
ENV LANG=C.UTF-8 
ENV LC_ALL "en_US.UTF-8"
ENV PATH /opt/conda/bin:$PATH
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone

RUN apt-get update && \
    apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    gettext-base git mercurial subversion \
    tmux && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> /home/workspace/.bashrc && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> /home/workspace/.zshrc && \
    chown -R 1000:1000 /opt/conda

RUN apt-get update && \
    apt-get install -y curl grep sed dpkg && \
    TINI_VERSION="$(curl -L -s https://github.com/krallin/tini/releases/latest |  grep -o "/v.*\"" | sed 's:^..\(.*\).$:\1:' | cut -d '"' -f1 | sed -n '$p')" && \
    curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.deb" > tini.deb && \
    cat tini.deb &&\
    dpkg -i tini.deb && \
    rm tini.deb && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install GitHub CLI
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/etc/apt/trusted.gpg.d/githubcli-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/trusted.gpg.d/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" > /etc/apt/sources.list.d/github-cli.list && \
    apt update && \
    apt install gh

COPY entry.sh /bin
RUN mkdir -p /home/workspace/.irods
RUN chown -R 1000:1000 /home/workspace/

ENTRYPOINT ["bash", "/bin/entry.sh"]
