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

