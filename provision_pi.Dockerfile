##
## Copyright (c) 2023 VIDAL & ASTUDILLO Ltda and others.
##
## This program and the accompanying materials are made available under the
## terms of the MIT License which accompanies this distribution, and is 
## available at:
## https://github.com/vidalastudillo/provision_pi/blob/main/LICENSE
##


FROM debian:bullseye-slim


# Enviroment variables retrieved from the compose file
ARG PI_USERNAME
ARG PI_PASSWORD
ARG PI_HOST_PUID
ARG PI_HOST_PGID

# Install utilities:
#  - build-essential and make, to build usbboot
#  - nano: to edit text files
#  - git: to download usboot
#  - bash: for scripting
#  - strace: to diagnose https://strace.io
#  - usbutils: that provides lsusb
# And required packages per:
#  - https://github.com/raspberrypi/usbboot#linux--cygwin--wsl
RUN apt-get update && \
    apt-get install -y \
    sudo \
    build-essential \
    make \
    nano \
    git \
    bash \
    strace \
    usbutils \
    libusb-1.0-0-dev \
    pkg-config


# Creates the user their home, with bash shell, as root, part of the sudo group, with password hashed in MD5
RUN useradd -m -d /home/$PI_USERNAME -s /bin/bash -g root -G sudo -u $PI_HOST_PUID $PI_USERNAME -p "$(openssl passwd -1 "${PI_PASSWORD}")"
USER $PI_USERNAME
WORKDIR /home/$PI_USERNAME
