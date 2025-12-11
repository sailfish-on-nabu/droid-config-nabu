iVALID_PRODUCTS=(FP5)

FLASH_OPS=(
"getvar_fail_if unlocked no"
"flash boot_a hybris-boot.img"
"flash boot_b hybris-boot.img"
"flash dtbo_a dtbo.img"
"flash dtbo_b dtbo.img"
"flash vendor_boot_a vendor_boot.img"
"flash vendor_boot_b vendor_boot.img"
"flash userdata sailfish.img001"
)

GETVAR_ERROR_unlocked="
This device has not been unlocked, but you need that for flashing.
Please go to https://en.miui.com/unlock/index.html and see instructions how to unlock your device.
"

FLASH_COMPLETED_MESSAGE="
Remove the USB cable and bootup the device by pressing powerkey.
"
