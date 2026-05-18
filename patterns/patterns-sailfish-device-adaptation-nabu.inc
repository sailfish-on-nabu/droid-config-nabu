# Feel free to disable non-critical HA parts during devel by commenting lines out
# Generated in hadk by executing: rpm/dhd/helpers/add_new_device.sh

%package -n patterns-sailfish-device-adaptation-nabu
Summary: Jolla HW Adaptation nabu
Requires: kernel-adaptation-nabu
Requires: firmware-xiaomi-nabu
Requires: droid-config-nabu-sailfish
Requires: droid-config-nabu-pulseaudio-settings
Requires: droid-config-nabu-policy-settings
Requires: droid-config-nabu-preinit-plugin
# Requires: droid-config-nabu-flashing
Requires: droid-config-nabu-bluez5
Requires: droid-hal-version-nabu

# Device-specific audio profiles
Requires: alsa-ucm-conf-nabu

# Needed for callaudio-trigger.sh
Requires: alsa-utils

# Needed for kernel module loading (e.g. in connman for iptables)
Requires: kmod

# Mesa packages
Requires: mesa-dri-drivers
Requires: mesa-libEGL
Requires: mesa-libGLESv2
Requires: mesa-libgbm
#Requires: mesa-libglapi
Requires: wayland-egl


# Bluetooth
Requires: bluebinder

# Vibra
Requires: ngfd-plugin-native-vibrator
Requires: libngf-qt5-qtfeedback

# Needed for /dev/touchscreen symlink
Requires: qt5-plugin-generic-evdev

# The -dummy-af is needed for newer devices that run the main
# audiosystem-passthrough in qti mode (e.g. >=Android 9 Qualcomm),
# to fix non-responding Camera app and/or voice during a phone call:
Requires: audiosystem-passthrough-dummy-af

# for audio recording to work:
Requires: qt5-qtmultimedia-plugin-mediaservice-gstmediacapture

# These need to be per-device due to differing backends (fbdev, eglfs, hwc, ..?)
Requires: qt5-qtwayland-wayland_egl
Requires: qt5-plugin-platform-eglfs
Requires: qtscenegraph-adaptation

Requires: libcamera

# USB mode controller
Requires: usb-moded

# hammerhead, grouper, and maguro use this in scripts, so include for all
Requires: rfkill

# enable device lock and allow to select untrusted software
Requires: jolla-devicelock-daemon-encsfa

# NFC support
# 1. binder plugin requires Android 8 or a newer base
# 2. pn54x plugin talks directly to pn54x driver
# These plugins are mutually exclusive, you need to pick one:
#Requires: nfcd-binder-plugin
#Requires: nfcd-pn54x-plugin

# For torch
Requires: jolla-settings-system-flashlight

# For suspend to work with enabled Wi-Fi on newer Qualcomm devices
Requires: sailfish-connman-plugin-suspend

# Splash screen
Requires: yamuisplash

# for wait keymaster
Requires: libgbinder-tools

# better support shell and happy
Requires: gnu-bash

%description -n patterns-sailfish-device-adaptation-nabu
Pattern with packages for nabu HW Adaptation

%files -n patterns-sailfish-device-adaptation-nabu
