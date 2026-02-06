DESCRIPTION = "SPI dev test tool"
LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://spidev_test.c;md5=a7902020fe45f8644f6195b2fbcb9ccc"

SRC_URI += "\
    file://spidev_test.c \
    file://meson.build \
"

S = "${WORKDIR}/sources"
UNPACKDIR = "${S}"

inherit pkgconfig meson


