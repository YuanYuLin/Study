DEFAULTTUNE ?= "armv7ve-neon"

include conf/machine/include/soc-family.inc
include conf/machine/include/arm/arch-armv7ve.inc

TUNEVALID[arm1176jzfs] = "Enable arm1176jzfs specific processor optimizations"
TUNE_CCARGS .= "${@bb.utils.contains('TUNE_FEATURES', 'arm1176jzfs', ' -mcpu=arm1176jzf-s', '', d)}"
MACHINEOVERRIDES =. "${@bb.utils.contains('TUNE_FEATURES', 'arm1176jzfs', 'armv6:', '', d)}"

AVAILTUNES += "armv7ve-neon"
ARMPKGARCH:tune-armv7ve-neon = "armv7ve"
TUNE_FEATURES:tune-armv7ve-neon = "arm armv7ve vfp neon"
PACKAGE_EXTRA_ARCHS:tune-armv7ve-neon = "armv7ve armv7ve-neon"

# Kernel and bootloader
PREFERRED_PROVIDER_virtual/kernel ?= "linux-rpi2"
PREFERRED_PROVIDER_virtual/bootloader = "u-boot"

KERNEL_IMAGETYPE ?= "fitImage"
KERNEL_CLASSES ?= "kernel-fitimage"
INITRAMFS_IMAGE ?= "aspeed-image-initramfs"
INITRAMFS_FSTYPES ?= "cpio.xz"

