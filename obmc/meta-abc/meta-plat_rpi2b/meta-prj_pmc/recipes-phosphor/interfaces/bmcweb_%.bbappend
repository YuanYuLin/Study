FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " \
"

EXTRA_OEMESON:append = " \
    -Dkvm=disabled \
    -Dvm-websocket=disabled \
    -Dredfish-dump-log=enabled \
    -Dredfish-dbus-log=enabled \
    -Dbmcweb-logging=enabled \
    -Dredfish-allow-deprecated-power-thermal=enabled \
    -Dredfish-new-powersubsystem-thermalsubsystem=disabled \
"
