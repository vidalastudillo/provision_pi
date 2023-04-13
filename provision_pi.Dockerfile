##
## Copyright (c) 2023 VIDAL & ASTUDILLO Ltda and others.
##
## This program and the accompanying materials are made available under the
## terms of the MIT License which accompanies this distribution, and is 
## available at:
## https://github.com/vidalastudillo/provision_pi/blob/main/LICENSE
##


FROM debian:bullseye-slim

# Install utilities and required packages per:
# https://github.com/raspberrypi/usbboot#linux--cygwin--wsl
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    make \
    bash \
    nano \
    git \
    libusb-1.0-0-dev \
    pkg-config
