#!/bin/bash

mkdir -p /odm/etc
mount --bind /odm_root/etc /odm/etc

# wlan
mount --bind /lib/modules/`uname -r`/wlan.ko /vendor/lib/modules/qca_cld3_wlan.ko
mount --bind /usr/libexec/droid-hybris/system/lib64/hw/audio.hidl_compat.default.so /vendor/lib64/hw/audio.primary.msmnile.so

# bt
mount --bind /usr/libexec/droid-hybris/system/bluebinder_wait.sh /usr/bin/droid/bluebinder_wait.sh


# audio
mount --bind /usr/libexec/droid-hybris/vendor/etc/audio/audio_policy_configuration.xml /vendor/etc/audio/audio_policy_configuration.xml
