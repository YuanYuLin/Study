FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " file://led-group-config.json"

do_install:append() {
        install -m 0644 ${WORKDIR}/led-group-config.json ${D}${datadir}/phosphor-led-manager/
}

