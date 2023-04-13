# Description

This provides an environment based in a container to deploy Raspberry Pi utilities related to the provisioning of their devices. Currently it contains:

  - `raspberrypi/usbboot`: [See here](https://github.com/raspberrypi/usbboot)

Once deployed, a shell can be attached to perform the operations like:

  - eeprom upgrade
  - image transfer

While there is nothing fancy here, this repo should provide an easy to deploy service that helps with the preparation of several Pi devices in a reliable fashion, using nothing more than a Linux machine with an USB port.

See [raspberrypi/cmprovision](https://github.com/raspberrypi/cmprovision) for a more elaborated solution.


# Quick Setup

1. Clone this in a Linux machine (macOS / Windows don't provide access to their USB ports)

> git clone https://github.com/vidalastudillo/provision_pi

2. Configure the service

Make a copy of the .env template and update it according to your preferences and using your favorite editor if it is not `nano`:

> cd provision_pi
> cp template.env .env
> nano .env



# Use

Once in the folder `provision_pi` use the [`run.sh`](run.sh) script to manage the container deployment:

- To start the container:

> ./run.sh start

- To attach a terminal to the container:

> ./run.sh attach

Note the prompt `root@provision_pi` in your terminal, which means you are inside the container.

- To deploy `usbboot` inside the container

Switch to the persistent folder

> cd /root/data

Based on the instructions from https://github.com/raspberrypi/usbboot build `usbboot` and enjoy.

> git clone --depth=1 https://github.com/raspberrypi/usbboot
> cd usbboot
> make
> ./rpiboot
