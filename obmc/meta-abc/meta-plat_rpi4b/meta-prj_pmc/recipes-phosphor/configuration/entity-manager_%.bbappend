FILESEXTRAPATHS:append := ":${THISDIR}/files"

inherit obmc-phosphor-systemd systemd

SRC_URI += " \
    file://psu_chassis.json \
    file://psu_crps.json \
    file://psu_crps_premium.json \
"

do_install:append() {
     rm -f ${D}${datadir}/entity-manager/configurations/*.json
     install -d ${D}${datadir}/entity-manager/configurations
     install -m 0444 ${UNPACKDIR}/psu_chassis.json ${D}${datadir}/entity-manager/configurations
     install -m 0444 ${UNPACKDIR}/psu_crps.json ${D}${datadir}/entity-manager/configurations
     install -m 0444 ${UNPACKDIR}/psu_crps_premium.json ${D}${datadir}/entity-manager/configurations
}

