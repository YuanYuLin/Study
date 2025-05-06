DEFAULTTUNE ?= "cortexa7thf-neon-vfpv4"

include conf/machine/include/abc-base.inc
include conf/machine/include/arm/armv7a/tune-cortexa7.inc

SERIAL_CONSOLES ?= "115200;ttyAMA0"
