FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
inherit obmc-phosphor-systemd

SRC_URI += " \
    file://psu.json \
    "

PACKAGECONFIG:append = " monitor-ng"

PSU_MONITOR_ENV_FMT = "power-supply-monitor-{0}.conf"
SYSTEMD_ENVIRONMENT_FILE:${PN}-monitor:append = " ${@compose_list(d, 'PSU_MONITOR_ENV_FMT', 'OBMC_POWER_SUPPLY_INSTANCES')}"

do_install:append() {
    install -D ${UNPACKDIR}/psu.json ${D}${datadir}/phosphor-power/psu.json
}

FILES:${PN} += "${datadir}/phosphor-power/psu.json"

