DEFAULTTUNE = "aarch64"
ARMSTUB ?= "armstub8-gic.bin"

include conf/machine/include/abc-base.inc
require conf/machine/include/arm/armv8a/tune-cortexa72.inc

SERIAL_CONSOLES ?= "115200;ttyS0"

