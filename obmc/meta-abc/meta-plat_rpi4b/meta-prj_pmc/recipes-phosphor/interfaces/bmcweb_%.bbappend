FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " \
    file://002-redfish-core.lib.power_supply.hpp.patch \
"

EXTRA_OEMESON:append = " \
    -Dkvm=disabled \
    -Dvm-websocket=disabled \
    -Dredfish-dump-log=enabled \
    -Dredfish-dbus-log=enabled \
    -Dbmcweb-logging=enabled \
    -Dredfish-allow-deprecated-power-thermal=disabled \
    -Dredfish-new-powersubsystem-thermalsubsystem=enabled \
"
