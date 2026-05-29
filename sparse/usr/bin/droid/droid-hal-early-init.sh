#!/bin/bash

mkdir -p /odm/etc
mount --bind /odm_root/etc /odm/etc

# for usb suspend
echo none > /sys/devices/platform/soc/a600000.ssusb/mode

# wlan
mount --bind /lib/modules/`uname -r`/wlan.ko /vendor/lib/modules/qca_cld3_wlan.ko

# bt
mount --bind /usr/libexec/droid-hybris/system/bluebinder_wait.sh /usr/bin/droid/bluebinder_wait.sh

# waydroid binderfs
cd /dev/
ln -s binderfs/*puddle* .
chmod 666 binderfs/*puddle*
