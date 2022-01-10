#!/bin/bash
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
parse-android-dynparts /dev/sda23
mount /dev/mapper/dynpart-system_a  /system
mount /dev/mapper/dynpart-system_ext_a /system_ext
mount /dev/mapper/dynpart-vendor_a  /vendor
mount /dev/mapper/dynpart-odm_a   /odm
mount /dev/mapper/dynpart-product_a /product

