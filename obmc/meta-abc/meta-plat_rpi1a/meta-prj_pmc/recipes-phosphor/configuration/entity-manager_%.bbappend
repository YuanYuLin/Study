FILESEXTRAPATHS:append := ":${THISDIR}/files"
SRC_URI:append = " \
    file://lenvo_cffv5.json \
    file://lenvo_crps.json \
"

do_install:append() {
     rm -f ${D}${datadir}/entity-manager/configurations/*.json
     install -d ${D}${datadir}/entity-manager/configurations
     install -m 0444 ${WORKDIR}/lenvo_cffv5.json ${D}${datadir}/entity-manager/configurations
     install -m 0444 ${WORKDIR}/lenvo_crps.json ${D}${datadir}/entity-manager/configurations
}

