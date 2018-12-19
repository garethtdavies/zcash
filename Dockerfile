# Dockerfile to build an Ubuntu image to build zcashd on Linux and cross-compile for Windows and ARM (TODO)
# Provides all dependencies to run all test suites
# --------------------------------------------------------------------------------------------------------
# Build this with docker and store in GitLab container registry
# docker build -t registry.gitlab.com/garethtdavies/zcash/ubuntu18-04 .
# --------------------------------------------------------------------------------------------------------

# Use Ubuntu 18.04 as base image as tested for Windows cross-compile
FROM ubuntu:bionic

LABEL maintainer="hello@garethtdavies.com"

# Fix for tzdata configuration
ENV DEBIAN_FRONTEND=noninteractive

# Install all dependencies to build on Linux
RUN apt-get update && apt-get install -y \
    build-essential pkg-config libc6-dev m4 g++-multilib \
    autoconf libtool ncurses-dev unzip git python python-zmq \
    zlib1g-dev wget curl bsdmainutils automake

# Windows cross-compile dependencies
RUN apt-get install -y mingw-w64 && \
    update-alternatives --set x86_64-w64-mingw32-gcc /usr/bin/x86_64-w64-mingw32-gcc-posix && \
    update-alternatives --set x86_64-w64-mingw32-g++ /usr/bin/x86_64-w64-mingw32-g++-posix

# Dependencies for testing
RUN apt-get install -y python-pip tzdata \
    && pip install pyblake2 pyflakes

# TODO ARM cross-compile dependencies
# RUN apt-get install -y g++-arm-linux-gnueabihf