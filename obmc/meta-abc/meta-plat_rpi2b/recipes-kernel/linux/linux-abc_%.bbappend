FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " \
  file://defconfig \
  file://001-arch.arm.boot.dts.broadcom.bcm2835-rpi-a.dts.2.18.0.patch \
  "

