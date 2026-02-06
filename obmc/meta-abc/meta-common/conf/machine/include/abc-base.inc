include conf/machine/include/soc-family.inc

PREFERRED_PROVIDER_virtual/kernel ?= "linux-abc"
PREFERRED_PROVIDER_virtual/bootloader ?= "u-boot"

KERNEL_IMAGETYPE ?= "fitImage"
KERNEL_CLASSES ?= "kernel-fitimage"
INITRAMFS_FSTYPES ?= "cpio.xz"

#FLASH_SIZE = "32768"
FLASH_SIZE = "65536"
#FLASH_SIZE = "131072"

# Disable hardware root of trust by default.
# If users want to enable secure boot,
# please do the following steps.
# 1. Set SOCSEC_SIGN_ENABLE to “1”.
# 2. Provide platform OTP config.
# There was an example in p10bmc.
# If users enable socsec signing but do not provide OTP config,
# u-boot will be built failed.
SOCSEC_SIGN_ENABLE = "0"

#MACHINE_FEATURES += "obmc-bmc-state-mgmt"
#MACHINE_FEATURES += "obmc-chassis-state-mgmt"
MACHINE_FEATURES += "obmc-host-ipmi"
#MACHINE_FEATURES += "obmc-host-state-mgmt"
#MACHINE_FEATURES += "obmc-phosphor-chassis-mgmt"
#MACHINE_FEATURES += "obmc-phosphor-flash-mgmt"
#MACHINE_FEATURES += "obmc-phosphor-fan-mgmt"

# PREFERRED_PROVIDER_virtual/obmc-chassis-mgmt = "packagegroup-test-apps"
# PREFERRED_PROVIDER_virtual/obmc-system-mgmt = "packagegroup-test-apps"
# PREFERRED_PROVIDER_virtual/obmc-flash-mgmt = "packagegroup-test-apps"
PREFERRED_PROVIDER_virtual/obmc-host-ipmi-hw = "phosphor-ipmi-ssif"
# PREFERRED_PROVIDER_virtual/obmc-fan-mgmt = "packagegroup-test-apps"

VIRTUAL-RUNTIME_obmc-sensors-hwmon ?= "dbus-sensors"
