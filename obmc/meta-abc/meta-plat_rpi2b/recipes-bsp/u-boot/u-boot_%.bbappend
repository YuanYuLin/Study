FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " \
  file://usb_net.cfg \
  file://001-include.configs.rpi.h.patch \
  "

