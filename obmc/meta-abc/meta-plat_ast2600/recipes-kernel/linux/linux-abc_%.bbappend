FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " \
  file://defconfig \
  file://gpio_debug.cfg \
  file://i2c_debug.cfg \
  file://ipmb_dev.cfg \
  file://001-arch.arm.boot.dts.aspeed.aspeed-ast2600-evb.dts.patch \
  "

