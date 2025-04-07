KBRANCH ?= "dev-6.6"
LINUX_VERSION ?= "6.6.51"

SRCREV = "ca2478a7d974f38d29d27acb42a952c7f168916e"

require linux.inc

SRC_URI:append = " \
  file://defconfig \
  file://gpio_debug.cfg \
  file://i2c_debug.cfg \
  file://ipmb_dev.cfg \
  file://001-arch.arm.boot.dts.aspeed.aspeed-ast2600-evb.dts.patch \
  "
