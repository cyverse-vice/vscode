[![Project Supported by CyVerse](https://img.shields.io/badge/Supported%20by-CyVerse-blue.svg)](https://learning.cyverse.org/projects/vice/en/latest/) [![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active) [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.3246932.svg)](https://doi.org/10.5281/zenodo.3246932) [![license](https://img.shields.io/badge/license-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

# VS Code Server for CyVerse

A ready-to-use VS Code Server container with integrated data science tools, perfect for cloud development environments and the CyVerse Discovery Environment (DE).

[![Harbor Build Status](https://github.com/cyverse-vice/vscode/actions/workflows/harbor.yml/badge.svg)](https://github.com/cyverse-vice/vscode/actions) ![GitHub commits since tagged version](https://img.shields.io/github/commits-since/cyverse-vice/vscode/latest/main?style=flat-square)

## Quick Start

Get started immediately using our pre-built container in the CyVerse Discovery Environment:

<a href="https://de.cyverse.org/apps/de/091c830a-4be1-11ec-aad9-008cfa5ae621/launch" target="_blank"><img src="https://img.shields.io/badge/VS%20Code-latest-6C33AF?style=plastic&logo=visualstudiocode"></a>

## Features

This VS Code Server container comes with:

- **NVIDIA CUDA 12.5** - GPU acceleration support
- **Miniconda & Mamba** - Efficient Python package management
- **Ollama** - Run AI models locally
- **GitHub CLI** - Integrated GitHub command-line interface
- **Git Credential Manager** - Seamless Git authentication
- **GoCommands** - CyVerse Data Store integration
- **AWS CLI v2** - Amazon Web Services command-line interface
- **S3 CLI (s3cmd)** - Command-line S3 client and backup tool
- **S3FS-FUSE** - Mount S3 buckets as filesystems
- **Globus Connect Server** - High-performance data transfer
- **Claude Code** - AI-powered VS Code assistant
- **Pre-installed VS Code Extensions**:
  - Python
  - Jupyter
  - vscode-icons
  - Claude Dev

## Run Docker Locally

You can run this container on your local machine or a virtual machine:

```bash
# Pull the container
docker pull harbor.cyverse.org/vice/vscode:latest

# Run without GPU
docker run -it --rm -d -p 8080:8080 harbor.cyverse.org/vice/vscode:latest

# Run with GPU support
docker run -it --rm -d -p 8080:8080 --gpus all harbor.cyverse.org/vice/vscode:latest
```

After running the container, access VS Code at [http://localhost:8080](http://localhost:8080)

## CyVerse Integration

When used in the CyVerse Discovery Environment, this container automatically:

- Connects to your CyVerse Data Store
- Transfers your Git and SSH configurations
- Provides access to CyVerse's high-performance computing and storage

## Build Your Own Container

You can extend this container with your own tools:

```dockerfile
FROM harbor.cyverse.org/vice/vscode:latest

# Add your own dependencies
RUN apt update && apt install -y your-package-here

# Add your own Python packages
RUN mamba install -y -c conda-forge your-python-package
```

## Container Features

The Dockerfile implements several best practices:

- Robust user/group handling compatible with the base image
- Version-pinned dependencies for better reproducibility
- Layer optimization to minimize container size
- Built-in healthcheck for container monitoring
- CUDA 12.5 and NVIDIA driver integration
- Pre-configured VS Code extensions for Python development
- GitHub CLI integration for seamless Git operations
- Support for Kubernetes CSI-mounted environment files

## Advanced Usage

### Environment Files Support

The container supports loading environment variables from hidden `.env` files mounted via Kubernetes CSI drivers. Place `.env` files in the user's home directory:

- `~/.env` - Main environment file
- `~/.env.secrets` - Secrets and credentials
- `~/.env.production` - Production-specific variables

These files will be automatically loaded on container startup.

### Local Testing

For testing with mounted home directory:

```bash
docker run -it --rm -v /$HOME:/app --workdir /app -p 3000:3000 -e REDIRECT_URL=http://localhost:3000 harbor.cyverse.org/vice/vscode:latest
```

## Resources

- [Deploying your own Tools and Apps in CyVerse](https://learning.cyverse.org/vice/about/)
- [CyVerse GoCommands Documentation](https://learning.cyverse.org/ds/gocommands/)
- [CyVerse Learning Center](https://learning.cyverse.org/)

## Developer Notes

Add the VS Code launch button to your website:

```html
<a href="https://de.cyverse.org/apps/de/091c830a-4be1-11ec-aad9-008cfa5ae621/launch" target="_blank"><img src="https://img.shields.io/badge/VS%20Code-latest-6C33AF?style=plastic&logo=visualstudiocode"></a>
