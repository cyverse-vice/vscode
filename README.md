[![Project Supported by CyVerse](https://de.cyverse.org/Powered-By-CyVerse-blue.svg)](https://learning.cyverse.org/projects/vice/en/latest/) [![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active) [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.3246932.svg)](https://doi.org/10.5281/zenodo.3246932) [![license](https://img.shields.io/badge/license-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

# VS Code Server

VS Code Server with GPU support, AI tools, and data science integration for the [CyVerse Discovery Environment](https://learning.cyverse.org/vice/about/).

[![Harbor Build Status](https://github.com/cyverse-vice/vscode/actions/workflows/harbor.yml/badge.svg)](https://github.com/cyverse-vice/vscode/actions) ![GitHub commits since tagged version](https://img.shields.io/github/commits-since/cyverse-vice/vscode/latest/main?style=flat-square)

## Quick Launch

| Version | Launch |
|---------|--------|
| latest | <a href="https://de.cyverse.org/apps/de/45bdd058-2526-11f0-97cd-008cfa5ae621/launch" target="_blank" rel="noopener noreferrer"><img src="https://img.shields.io/badge/VS%20Code-latest-6C33AF?style=plastic&logo=visualstudiocode"></a> |

## Features

### AI Development Tools
- **Claude Code** - Anthropic AI coding assistant (`claude`)
- **Gemini CLI** - Google AI CLI (`gemini`)
- **OpenAI Codex** - OpenAI coding assistant (`codex`)
- **Ollama** - Run AI models locally
- **MCP Server** - Model Context Protocol filesystem server

### GPU & Machine Learning
- **NVIDIA CUDA 12.5** - GPU acceleration support
- **NVIDIA Driver 535** - Graphics driver
- **Miniconda & Mamba** - Efficient Python package management

### Development Tools
- **GitHub CLI (`gh`)** - Command-line tool for GitHub operations
- **Git Credential Manager** - Secure credential storage
- **AWS CLI** - Amazon Web Services CLI
- **Globus Connect** - Research data management

### VS Code Extensions (Pre-installed)
- **Python** - Python language support
- **Jupyter** - Notebook support
- **vscode-icons** - File icons
- **Claude Dev** - AI assistant integration

### CyVerse Integration
- **GoCommands (`gocmd`)** - CyVerse data transfer utilities
- **S3FS-FUSE** - Mount S3 buckets as filesystem
- **OSN Support** - Open Storage Network bucket mounting

### System Utilities
- **Monitoring** - htop, glances, nvtop (GPU monitoring)
- **Build tools** - gcc, development essentials

## Run Locally

```bash
# Pull the container
docker pull harbor.cyverse.org/vice/vscode:latest

# Run without GPU
docker run -it --rm -p 8080:8080 harbor.cyverse.org/vice/vscode:latest

# Run with GPU support
docker run -it --rm -p 8080:8080 --gpus all harbor.cyverse.org/vice/vscode:latest
```

Access VS Code at: http://localhost:8080

### With mounted home directory
```bash
docker run -it --rm -v $HOME:/app --workdir /app -p 8080:8080 harbor.cyverse.org/vice/vscode:latest
```

## CyVerse Integration

When running in the CyVerse Discovery Environment, this container automatically:

- Connects to your CyVerse Data Store
- Transfers your Git and SSH configurations
- Provides access to CyVerse's high-performance computing and storage

## Build Your Own Container

```dockerfile
FROM harbor.cyverse.org/vice/vscode:latest

# Add system packages
USER root
RUN apt-get update && apt-get install -y your-package

# Add Python packages
USER vscode
RUN mamba install -y -c conda-forge your-python-package
```

## Container Architecture

This container implements several best practices:

- **Robust user handling** - Compatible with base image user/group setup
- **Version-pinned dependencies** - Better reproducibility
- **Layer optimization** - Minimized container size
- **Built-in healthcheck** - Container monitoring at `/`
- **CUDA integration** - GPU acceleration ready
- **Pre-configured extensions** - Ready for Python development

## Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `GCM_CREDENTIAL_STORE` | Git credential storage method | `cache` |

## Ports

| Port | Service |
|------|---------|
| 8080 | VS Code Server (HTTP) |
| 8443 | VS Code Server (HTTPS) |

## Resources

- [CyVerse VICE Documentation](https://learning.cyverse.org/vice/about/)
- [Integrate Your Own Tools](https://learning.cyverse.org/de/create_apps/)
- [GoCommands Documentation](https://learning.cyverse.org/ds/gocommands/)
- [CyVerse Learning Center](https://learning.cyverse.org/)
