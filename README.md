# docker-yarn
Dockerfile for generating yarn images from a node image.

To make it easier for anyone to build the yarn image from any version of node regardless of the
base OS, this image will verify which package manager is available.

## Usage

It is assumed you already have docker installed.

Login to Docker Hub

    docker login
    
Pull the image. By the default, the image uses node 12.18.3.

    docker pull gmolaire/docker-yarn

To run a command against your project assuming your running the container in its directory:

    docker run -it --rm -w "/usr/app" -v "$PWD":/usr/app gmolaire/docker-yarn yarn <COMMAND>

## Limitation

- This will not work for openjdk Windows specific images
- The main user is root

## Building

To build, you need to specify the desired node and yarn versions via `--build-arg` parameters:

    export NODE_VERSION=12.18.3
    export YARN_VERSION=1.22.4

    docker build --build-arg NODE_VERSION --build-arg YARN_VERSION -t gmolaire/yarn:$YARN_VERSION_$NODE_VERSION .

## Tag Format

The underscore (yarn version <-- `_` --> node version) splits the yarn version to the left and the node version to the right.