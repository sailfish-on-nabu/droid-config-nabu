# Feel free to disable non-critical HA parts during devel by commenting lines out
# Generated in hadk by executing: rpm/dhd/helpers/add_new_device.sh

%package -n patterns-sailfish-device-configuration-nabu
Summary: Jolla Configuration nabu
Requires: patterns-sailfish-device-configuration-common-nabu
Requires: patterns-sailfish-device-adaptation-nabu

# Early stages of porting benefit from these:
Requires: patterns-sailfish-device-tools
Requires: libcamera-tools

Requires: sailfish-content-graphics-z%{icon_res}

# Introduced starting Sailfish OS 2.0.4.x:
# 3rd party accounts like Twitter, VK, cloud services, etc
Requires: jolla-settings-accounts-extensions-3rd-party-all

# Introduced starting Sailfish OS 2.1.1.26
# Required for Jolla Store Access
Requires: patterns-sailfish-consumer-generic

# For Mozilla location services (online)
Requires: geoclue-provider-mlsdb

# Devices with 2G or more memory should also include this booster
# to improve camera startup times and the like
Requires: mapplauncherd-booster-silica-qt5-media

Recommends: harbour-storeman
Recommends: sailfishos-chum-gui
Recommends: harbour-souniaoime

%description -n patterns-sailfish-device-configuration-nabu
Pattern with packages for nabu configurations

%files -n patterns-sailfish-device-configuration-nabu
