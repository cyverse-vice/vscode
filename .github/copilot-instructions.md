# Copilot Instructions

This document provides instructions for AI coding agents to effectively work with the `vscode` repository.

## Big Picture

This repository contains Dockerfiles for building a VS Code Server container for the CyVerse Discovery Environment. The container is designed for cloud development and comes pre-configured with data science tools.

The repository is organized by version numbers, with each version having its own `Dockerfile` and `entry.sh` script. The `latest` directory contains the most recent version. The `geospatial/latest` directory contains a specialized version with geospatial tools.

## Key Workflows

### Building a Container

To build a container for a specific version, navigate to the version's directory and run the `docker build` command. For example, to build the `latest` version:

```bash
cd latest
docker build -t harbor.cyverse.org/vice/vscode:latest .
```

### Running a Container

To run a container, use the `docker run` command. For example, to run the `latest` version:

```bash
docker run -it --rm -d -p 8080:8080 harbor.cyverse.org/vice/vscode:latest
```

### Adding a New Version

To add a new version, create a new directory with the version number and copy the `Dockerfile` and `entry.sh` from a previous version. Then, update the `Dockerfile` with the new version's dependencies.

## Conventions

- Each version of the VS Code server is in its own directory.
- The `latest` directory always points to the most recent version.
- The `geospatial` directory contains a specialized version of the container.
- The `Dockerfile` for each version should be as self-contained as possible.
- The `entry.sh` script is the entrypoint for the container and handles the setup of the VS Code server.

## Key Files

- `README.md`: Provides an overview of the project.
- `*/Dockerfile`: The Dockerfile for each version of the VS Code server.
- `*/entry.sh`: The entrypoint script for each version of the VS Code server.
- `geospatial/latest/environment.yml`: The conda environment for the geospatial version.
