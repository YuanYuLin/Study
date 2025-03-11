FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " \
  file://000-configs.ast2600_openbmc_spl_defconfig.patch \
  file://001-drivers.core.uclass.c.patch \
  file://002-arch.arm.dts.ast2600-evb.dts.patch \
  file://003-include.configs.evb_ast2600_spl.h.patch \
  file://004-include.configs.aspeed-common.h.patch \
  "

