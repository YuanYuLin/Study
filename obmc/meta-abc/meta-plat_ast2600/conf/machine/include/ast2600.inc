DEFAULTTUNE ?= "armv7ahf-vfpv4d16"

include conf/machine/include/abc-base.inc
include conf/machine/include/arm/arch-armv7a.inc


# MACHINE_EXTRA_RRECOMMENDS += "udev-aspeed-vuart udev-aspeed-mtd-partitions"
MACHINE_FEATURES += "hw-rng"


SERIAL_CONSOLES ?= "115200;ttyS4"

DEFAULTTUNE ?= "armv7ahf-vfpv4d16"

UBOOT_ENTRYPOINT ?= "0x80001000"
UBOOT_LOADADDRESS ?= "0x80001000"

