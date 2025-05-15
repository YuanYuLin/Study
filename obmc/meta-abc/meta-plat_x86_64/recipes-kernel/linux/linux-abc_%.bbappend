FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

DEPENDS += "elfutils-native"

SRC_URI:append = " \
  file://defconfig \
  "

