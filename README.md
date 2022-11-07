 [![Project Supported by CyVerse](https://img.shields.io/badge/Supported%20by-CyVerse-blue.svg)](https://learning.cyverse.org/projects/vice/en/latest/) [![Project Status: WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip) [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.3246932.svg)](https://doi.org/10.5281/zenodo.3246932) [![license](https://img.shields.io/badge/license-MIT-yellow.svg)](https://opensource.org/licenses/MIT)  

 # Open VSCode Server

[Visual Studio Code](https://github.com/microsoft/vscode) built from [GitPod's Open VS Code Server](https://hub.docker.com/r/gitpod/openvscode-server) base image.

[![!Harbor](https://github.com/cyverse-vice/vscode/actions/workflows/harbor.yml/badge.svg)](https://github.com/cyverse-vice/vscode/actions) ![GitHub commits since tagged version](https://img.shields.io/github/commits-since/cyverse-vice/vscode/latest/main?style=flat-square) 


| quick launch |
| ------------ |
| <a href="https://de.cyverse.org/apps/de/091c830a-4be1-11ec-aad9-008cfa5ae621/launch" target="_blank"><img src="https://img.shields.io/badge/VS%20Code-latest-6C33AF?style=plastic&logo=visualstudiocode"></a> |

## Run Docker locally or on a Virtual Machine

To run the container, you must first pull it from our private/public [Harbor Registry](https://harbor.cyverse.org/harbor/projects), or activate a [CyVerse Account](https://user.cyverse.org/services/mine) and use it in our data science workbench, called the "[Discovery Environment](https://de.cyverse.org/apps/de/091c830a-4be1-11ec-aad9-008cfa5ae621/launch)" or DE for short.

A Docker container hosted on CyVerse Harbor Registry <https://harbor.cyverse.org/harbor/projects/17/repositories/vscode>

```
docker pull harbor.cyverse.org/vice/vscode:latest
```

```
docker run -it --rm -d -p 3000:3000 harbor.cyverse.org/vice/vscode:latest
```

## Run your own Docker container in CyVerse VICE

[Deploying your own Tools and Apps in CyVerse](https://learning.cyverse.org/vice/about/)

You can build a new Docker container with additional dependencies from this Docker Hub image by using the `FROM harbor.cyverse.org/vice/vscode:latest` at the beginning of your own Dockerfile.

###### Developer notes

Add the <a href="https://de.cyverse.org/apps/de/091c830a-4be1-11ec-aad9-008cfa5ae621/launch" target="_blank"><img src="https://img.shields.io/badge/VS%20Code-latest-6C33AF?style=plastic&logo=visualstudiocode"></a> badge to your webpage: 
```
 <a href="https://de.cyverse.org/apps/de/091c830a-4be1-11ec-aad9-008cfa5ae621/launch" target="_blank"><img src="https://img.shields.io/badge/VS%20Code-latest-6C33AF?style=plastic&logo=visualstudiocode"></a>
```

To test the container locally:

```
docker run -it --rm -v /$HOME:/app --workdir /app -p 3000:3000 -e REDIRECT_URL=http://localhost:3000 harbor.cyverse.org/vice/vscode:latest
```
