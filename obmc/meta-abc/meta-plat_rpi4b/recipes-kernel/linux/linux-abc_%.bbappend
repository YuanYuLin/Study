FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " \
  file://defconfig \
  file://001-arch.arm.boot.dts.broadcom.bcm2835-rpi-a.dts.patch \
  file://002-arch.arm.boot.dts.broadcom.bcm2835-rpi-a.dts.patch \
  file://003-arch.arm.boot.dts.broadcom.bcm2835-rpi-a.dts.patch \
  file://004-arch.arm.boot.dts.broadcom.bcm2835-rpi-a.dts.patch \
  "

