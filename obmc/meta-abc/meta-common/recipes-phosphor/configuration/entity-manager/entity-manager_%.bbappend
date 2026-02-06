FILESEXTRAPATHS:append := ":${THISDIR}/files"

inherit obmc-phosphor-systemd systemd

SRC_URI += " \
    file://001-src.topology.hpp.patch \
    file://002-src.topology.cpp.patch \
"
