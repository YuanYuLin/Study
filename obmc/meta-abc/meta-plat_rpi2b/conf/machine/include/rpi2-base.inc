DEFAULTTUNE ?= "cortexa7thf-neon-vfpv4"

include conf/machine/include/soc-family.inc
include conf/machine/include/arm/armv7a/tune-cortexa7.inc

PREFERRED_PROVIDER_virtual/kernel ?= "linux-rpi2b"
PREFERRED_PROVIDER_virtual/bootloader ?= "u-boot"

KERNEL_IMAGETYPE ?= "fitImage"
KERNEL_CLASSES ?= "kernel-fitimage"
INITRAMFS_IMAGE ?= "aspeed-image-initramfs"
INITRAMFS_FSTYPES ?= "cpio.xz"

SERIAL_CONSOLES ?= "115200;ttyAMA0"
