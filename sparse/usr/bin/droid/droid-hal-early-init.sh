#!/bin/bash

mkdir /odm/etc
mount --bind /odm_root/etc /odm/etc
mount --bind /lib/modules/`uname -r`/wlan.ko /vendor/lib/modules/qca_cld3_wlan.ko
