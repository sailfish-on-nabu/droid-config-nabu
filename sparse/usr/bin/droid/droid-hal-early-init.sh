#!/bin/bash
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
losetup -r /dev/loop0 /dev/disk/by-partlabel/super
dmsetup create --concise "$(parse-android-dynparts /dev/loop0)"

mkdir -p /product /system_ext /odm /system_root /system

mount /dev/mapper/dynpart-system_a /system_root
mount /dev/mapper/dynpart-vendor_a /vendor
mount /dev/mapper/dynpart-product_a /product
mount /dev/mapper/dynpart-system_ext_a /system_ext
mount /dev/mapper/dynpart-odm_a /odm

mount --bind /system_root/system /system
