DESCRIPTION = "Closed source binary files to help boot all raspberry pi devices."
LICENSE = "Broadcom-RPi"

LIC_FILES_CHKSUM = "file://LICENCE.broadcom;md5=c403841ff2837657b2ed8e5bb474ac8d"

inherit deploy nopackages

OUTPUT_DIR_NAME ?= "abc"
BOOTFILES_DIR_NAME ?= "bootfiles"
RPIFW_DATE ?= "20220830"

RPIFW_SRC_URI ?= "https://archive.raspberrypi.com/debian/pool/main/r/raspberrypi-firmware/raspberrypi-firmware_1.${RPIFW_DATE}.orig.tar.xz"
RPIFW_S ?= "${WORKDIR}/raspberrypi-firmware-1.${RPIFW_DATE}"

SRC_URI = "${RPIFW_SRC_URI}"
SRC_URI[sha256sum] = "2b27e4b3c4d2664a0a1d0dd8602bd80ea41dd006eb0ad9c67d7b659c9c8bb4e5"

PV = "${RPIFW_DATE}"

S = "${RPIFW_S}/boot"

do_deploy() {
    install -d ${DEPLOYDIR}/${BOOTFILES_DIR_NAME}

    for i in ${S}/*.elf ; do
        cp $i ${DEPLOYDIR}/${BOOTFILES_DIR_NAME}
    done
    for i in ${S}/*.dat ; do
        cp $i ${DEPLOYDIR}/${BOOTFILES_DIR_NAME}
    done
    for i in ${S}/*.bin ; do
        cp $i ${DEPLOYDIR}/${BOOTFILES_DIR_NAME}
    done

    echo "##See http://elinux.org/RPiconfig" > ${DEPLOYDIR}/${BOOTFILES_DIR_NAME}/config.txt
    echo "arm_freq=700"       >> ${DEPLOYDIR}/${BOOTFILES_DIR_NAME}/config.txt
    echo "core_freq=250"      >> ${DEPLOYDIR}/${BOOTFILES_DIR_NAME}/config.txt
    echo "kernel=u-boot.bin"  >> ${DEPLOYDIR}/${BOOTFILES_DIR_NAME}/config.txt
    echo "disable_overscan=1" >> ${DEPLOYDIR}/${BOOTFILES_DIR_NAME}/config.txt
    echo "gpu_mem_256=32"     >> ${DEPLOYDIR}/${BOOTFILES_DIR_NAME}/config.txt
    echo "gpu_mem_512=32"     >> ${DEPLOYDIR}/${BOOTFILES_DIR_NAME}/config.txt
    echo "gpu_mem=32"         >> ${DEPLOYDIR}/${BOOTFILES_DIR_NAME}/config.txt
    echo "sdram_freq=400"     >> ${DEPLOYDIR}/${BOOTFILES_DIR_NAME}/config.txt
    echo "over_voltage=0"     >> ${DEPLOYDIR}/${BOOTFILES_DIR_NAME}/config.txt
    echo "enable_uart=1"      >> ${DEPLOYDIR}/${BOOTFILES_DIR_NAME}/config.txt
    echo "arm_boost=1"        >> ${DEPLOYDIR}/${BOOTFILES_DIR_NAME}/config.txt

    cp -avr ${DEPLOYDIR}/${BOOTFILES_DIR_NAME}/* ${DEPLOY_DIR_IMAGE}/${OUTPUT_DIR_NAME}/
}

addtask deploy before do_build after do_install
do_deploy[dirs] += "${DEPLOYDIR}/${BOOTFILES_DIR_NAME}"
do_deploy[dirs] += "${DEPLOY_DIR_IMAGE}/${OUTPUT_DIR_NAME}"

PACKAGE_ARCH = "${MACHINE_ARCH}"

