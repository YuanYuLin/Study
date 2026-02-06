FILESEXTRAPATHS:prepend :="${THISDIR}/files:"

DEPENDS += "busybox"

SRC_URI += "file://obmc-init.sh \
           "

do_install:append() {
    install -m 0755 ${UNPACKDIR}/obmc-init.sh ${D}/init
}

