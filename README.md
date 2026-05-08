# Dockerized Festival 

Docker builds for [Festival](https://github.com/freehij/Festival), a PocketMine-MP fork.

# Features:

* Docker images with minimal Alpine base
  - Supported architectures: AMD64, ARM64
  - Images for PHP 8.0, PHP 8.1, PHP 8.2

# Running with docker compose
## Run setup wizard
You should run the setup wizard before running the server for the first time:
```
mkdir data
docker run --rm -it --mount type=bind,src=./data,dst=/server/data ghcr.io/doggielicc/festival:1.5
```
After completing the setup, you must stop the server and use the `docker-compose.yml` file to run it
```
docker compose up -d
```

# Building with docker
First clone this repo and enter it
## Regular build (single arch)
```
docker build . -t festival
```
## Multi-arch Build
```
docker build . -f Dockerfile.multiarch --platform linux/amd64,linux/arm64 -t festival-multiarch
```
## Export to file
Export PHP Binaries
```
docker build . -f Dockerfile.multiarch --target bin-export --output=out
```
Export PocketMine-MP.phar
```
docker build . -f Dockerfile.multiarch --target phar-export --output=out
```
## Build Arguments
  - `PHP_TAG` (Selects which tag to clone from [PHP-Binaries](https://github.com/pmmp/PHP-Binaries.git)) Default = `8.2`
  - `PHP_VERSION` (Selects the PHP Version to build) Default = `8.2.30`
  - `SOURCE_REPO` (Select which repo to download Festival from) Default = `https://github.com/freehij/Festival.git`
  - `SOURCE_BRANCH` (Select which branch from source repo to download) Default = `main`
