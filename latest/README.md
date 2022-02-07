# TOOL NAME HERE

## IMPORTANT: COPY THIS README.MD into every tagged folder in this repository

INFORMATION ABOUT THE CONTAINER HERE

SET UP CIRCLE CI
  
[![DockerHub](https://img.shields.io/badge/DockerHub-brightgreen.svg?style=popout&logo=Docker)](https://hub.docker.com/r/cyversevice/rstudio-base) [![CircleCI](https://circleci.com/gh/cyverse-vice/rstudio-base.svg?style=svg)](https://circleci.com/gh/cyverse-vice/<CONTAINER-NAME-HERE>) [![license](https://img.shields.io/badge/license-GPLv3-blue.svg)](https://opensource.org/licenses/GPL-3.0)  [![Project Supported by CyVerse](https://img.shields.io/badge/Supported%20by-CyVerse-blue.svg)](https://learning.cyverse.org/projects/vice/en/latest/)  [![Project Status: WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip) [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.3246932.svg)](https://doi.org/10.5281/zenodo.3246932)

image | tag | size | metrics | build | status |  
----- | --- | ---- | ------- | ------|--------|
<a href="https://de.cyverse.org/de/?type=quick-launch&quick-launch-id=19f6a94b-71b6-4034-a7a5-40f7bea0b85b&app-id=75773c76-8ee1-11e9-907f-008cfa5ae621" target="_blank"><img src="https://de.cyverse.org/Powered-By-CyVerse-blue.svg"></a> | [![](https://images.microbadger.com/badges/version/cyversevice/<CONTAINER-NAME-HERE>.svg)](https://microbadger.com/images/cyversevice/<CONTAINER-NAME-HERE> "<TAG>") |  [![](https://images.microbadger.com/badges/image/cyversevice/<CONTAINER-NAME-HERE>.svg)](https://microbadger.com/images/cyversevice/<CONTAINER-NAME-HERE> "<TAG>") | [![](https://img.shields.io/docker/pulls/cyversevice/<CONTAINER-NAME-HERE>.svg)](https://hub.docker.com/r/cyversevice/<CONTAINER-NAME-HERE>)  |  [![](https://img.shields.io/docker/cloud/automated/cyversevice/<CONTAINER-NAME-HERE>.svg)](https://hub.docker.com/r/cyversevice/<CONTAINER-NAME-HERE>/builds) | [![](https://img.shields.io/docker/build/cyversevice/<CONTAINER-NAME-HERE>.svg)](https://cloud.docker.com/u/cyversevice/repository/docker/cyversevice/<CONTAINER-NAME-HERE>)



# Instructions

## Run Docker locally or on a Virtual Machine

To run the RStudio container, you must first pull them from DockerHub, or activate a [CyVerse Account](https://user.cyverse.org/services/mine).

A Docker container for running RStudio is hosted on DockerHub.

```
docker pull cyversevice/<CONTAINER-NAME-HERE>:<TAG>
```

```
docker run -it --rm -d cyversevice/<CONTAINER-NAME-HERE>:<TAG>
```

The default username is `jovyan`

## Run Docker container in CyVerse VICE

Unless you plan on making changes to this container, you should just use the existing launch button above. 

###### Developer notes

To test the container locally:

```
docker run -it --rm -v /$HOME:/app --workdir /app -p 8888:8888 -e REDIRECT_URL=http://localhost:8888 cyversevice/jupyterlab-base:<TAG>
```
