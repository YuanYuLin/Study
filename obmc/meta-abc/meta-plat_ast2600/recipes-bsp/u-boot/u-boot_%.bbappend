FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " \
  file://001-arch.arm.dts.ast2600-evb.dts.patch \
  "

