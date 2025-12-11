= SAILFISH OS FOR FAIRPHONE 5 FLASHING GUIDE =

= FOR LINUX, WINDOWS AND OS X =

= STEP 1: GETTING AN Xiaomi Pad 5 =

Get an Xiaomi Pad 5. To be able to replace the Android system with Sailfish OS,
you will need to be able to unlock the bootloader of your device so that it
can be flashed with a new operating system.

Once you receive your device you will need to boot it into Android at least
once to update it to the latest Android version.
If you have a new device that's still under warranty, it's a good idea to
verify that all components of the device are working at this point, such as the
cameras and radio devices, as exchanging your device under warranty may become
more difficult once the bootloader has been unlocked.

= STEP 2: UNLOCKING THE BOOTLOADER =

Make sure that the system language of your Xiaomi Pad 5 device is set to English
before you continue.

Go to https://www.fairphone.com/en/bootloader-unlocking-code-for-fairphone/
website.
You should see additional instructions to prepare your device for unlocking:

* Type the IMEI and serial number and press "Get your unlock code".
  Please write it down somewhere.

* Once you have the unlock code follow the instructions in the
  "Instructions to unlock the bootloader" section

IMPORTANT! After unlocking bootloader you need to boot the device once to Android UI
           before proceeding to flashing Sailfish OS part.

Neither Linux nor OS X should require any additional drivers to connect to the
device in fastboot mode, but you will need to have installed the fastboot
command itself:

* Debian/Ubuntu/.deb distros: apt-get install android-tools-fastboot
* Fedora: yum install android-tools
* OS X: brew install android-sdk

= STEP 3 : FLASHING SAILFISH OS TO YOUR FAIRPHONE 5 =

Connect your device to your PC in Fastboot mode as follows:

* Disconnect your Xiaomi Pad device from your PC
* Turn off the device. Leave it off for at least fifteen seconds.
* Connect one end of a USB cable to your PC
* While holding the 'Volume Down' button, connect the other end of the USB cable
  to your Xiaomi Pad 5 device. You should see fastboot mode on display.
* On Windows, fastboot drivers are needed to properly detect the device.
* Launch the correct flashing script for your platform:
  * On Linux and OS X, use flash.sh
  * On Windows 7, 8 & 10, double-click 'flash-on-windows.bat'. If Windows warns
    you that it 'Protected your PC' by stopping the script from launching, click
    'More Info' then 'Run anyway'.
* Follow the instructions in the console window.
* When flashing has finished, reboot your device into Sailfish OS!

Happy flashing :)
