# Description

This provides an environment based in a container to deploy `Raspberry Pi` utilities related to the provisioning of their devices. Currently it contains:

  - `raspberrypi/usbboot`: [See here](https://github.com/raspberrypi/usbboot)

Once deployed, a shell can be attached to perform the operations like:

  - eeprom upgrade
  - image transfer

While there is nothing fancy here, this repo should provide an easy to deploy service that helps with the preparation of several Pi devices in a reliable fashion, using nothing more than a Linux machine with an USB port.

See [raspberrypi/cmprovision](https://github.com/raspberrypi/cmprovision) for a more elaborated solution.


# Quick Setup

1. Clone this in a Linux machine (macOS / Windows don't provide access to their USB ports)

``` shell
git clone https://github.com/vidalastudillo/provision_pi
```

2. Get the `Major Version` for the USB Driver in your Kernel

The container needs access to the `Pi` trough the host and as it is expected to connect / disconnect several times when the container it is already running.

The `Major Version` will be used to set the type of device allowed to have access by the container.

Connect the `Pi` to the host, with the jumper on the position to enable the `Boot` function.

Ask for the USB buses in the system and the devices connected to them:

``` shell
lsusb
```

Check for the line that contains something like: `Broadcom Corp. BCM2711 Boot` and take note of its `Bus` and `Device`.

ie. if the result is `Bus 001 Device 007: ID 0a5c:2711 Broadcom Corp. BCM2711 Boot`, then its `Bus` is `001` and its `Device` is `007`

Get the Major number for the `Bus` and `Device`:

``` shell
ls -la /dev/bus/usb/001/007
```

ie. if the result is `crw-rw-r-- 1 root root 189, 34 Apr 13 21:23 /dev/bus/usb/001/007` the number is `189` which will be used in the next step.


3. Configure the service

Make a copy of the `.env` template and update it according to your preferences and using your favorite editor if it is not `nano`:

``` shell
cd provision_pi
cp template.env .env
nano .env
```

4. Create the folder in your host to store the persistent home folder for the user

ie. mkdir pi

The name of the folder should be the same of the username you selected in the configuration, as this is the home folder of the user.

If this is not done before launching the container for the first time, docker will create with owner root, and you'll get issues with user permissions. To fix it, issue this in your host to change the ownership of the folder:

chown <the user id>:<the group id> <the path to the home user>

ie: chwon 1000:1000 ./pi


# Use

Once in the folder `provision_pi` use the [`run.sh`](run.sh) script to manage the container deployment:

### To start the container:

``` shell
./run.sh start
```


### To attach a terminal to the container:

``` shell
./run.sh attach
```

Note the prompt `root@provision_pi` in your terminal, which means you are inside the container.


### To deploy `usbboot` inside the container

Switch to the persistent folder

``` shell
cd /root/data
```

Based on the instructions from https://github.com/raspberrypi/usbboot build `usbboot` and enjoy!

``` shell
git clone --depth=1 https://github.com/raspberrypi/usbboot
cd usbboot
make
./rpiboot
```


# Resources


The solution to deal with the dynamic access to the connecting / disconnecting of the devices is based on:

https://stackoverflow.com/questions/24225647/docker-a-way-to-give-access-to-a-host-usb-or-serial-device/62758958#62758958


### Accessing USB Devices In Docker (ttyUSB0, /dev/bus/usb/... for fastboot, adb) without using --privileged

http://marc.merlins.org/perso/linux/post_2018-12-20_Accessing-USB-Devices-In-Docker-_ttyUSB0_-dev-bus-usb-_-for-fastboot_-adb_-without-using-privileged.html

https://stackoverflow.com/a/53892718/15786299

### Sharing devices (webcam, USB drives, etc) with Docker

https://stackoverflow.com/a/34472148/15786299


### Kernel devices: 

https://github.com/torvalds/linux/blob/master/Documentation/admin-guide/devices.txt
