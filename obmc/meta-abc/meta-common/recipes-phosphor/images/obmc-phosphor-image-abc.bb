SUMMARY = "Custom ABC image based on obmc-phosphor-image"
LICENSE = "MIT"

inherit image_types_abc
inherit obmc-phosphor-image

IMAGE_FSTYPES += " abc"

# The /etc/version file is misleading and not useful.  Remove it.
# Users should instead rely on /etc/os-release.
ROOTFS_POSTPROCESS_COMMAND += "remove_etc_version ; "

IMAGE_LINGUAS = ""
IMAGE_FEATURES += " \
        obmc-bmc-state-mgmt \
        obmc-bmcweb \
        obmc-chassis-mgmt \
        obmc-chassis-state-mgmt \
        obmc-console \
        obmc-devtools \
        obmc-fan-control \
        obmc-fan-mgmt \
        obmc-flash-mgmt \
        obmc-fru-ipmi \
        obmc-health-monitor \
        obmc-host-ctl \
        obmc-host-ipmi \
        obmc-host-state-mgmt \
        obmc-ikvm \
        obmc-inventory \
        obmc-leds \
        obmc-logging-mgmt \
        obmc-remote-logging-mgmt \
        obmc-rng \
        obmc-net-ipmi \
        obmc-sensors \
        obmc-software \
        obmc-system-mgmt \
        obmc-user-mgmt \
        obmc-user-mgmt-ldap \
        ${@bb.utils.contains_any('DISTRO_FEATURES', \
            'obmc-ubi-fs phosphor-mmc obmc-static-norootfs', \
            'read-only-rootfs', '', d)} \
        ssh-server-dropbear \
        obmc-debug-collector \
        obmc-network-mgmt \
        obmc-settings-mgmt \
        obmc-telemetry \
        "
# The shadow recipe provides the binaries(like useradd, usermod) needed by the
# phosphor-user-manager.
ROOTFS_RO_UNNEEDED:remove = "shadow"
