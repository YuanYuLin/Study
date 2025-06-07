
OUTPUT_DIR_NAME ?= "abc"

do_mk_abc_image() {

    #bbnote "Creating abc image... ${IMGDEPLOYDIR}"
    rm -fv ${IMGDEPLOYDIR}/*.sdimg

    ####
    bbnote "Creating emmc"
    SDIMG="${IMGDEPLOYDIR}/${IMAGE_NAME}.sdimg"
    SDIMG_SIZE=65536

    BOOT_START=4096
    BOOT_END=61440
    BOOT_BLOCKS=114688 #((BOOT_END - BOOT_START)*1024)/512
    ROOTFS_START=${BOOT_END}
    BOOTDD_VOLUME_ID=${OUTPUT_DIR_NAME}
    BOOT_OFFSET_BLOCKS=8192

    dd if=/dev/zero of=${SDIMG} bs=1024 count=0 seek=${SDIMG_SIZE}

    parted -s ${SDIMG} mklabel msdos
    parted -s ${SDIMG} unit KiB mkpart primary fat32 ${BOOT_START} ${BOOT_END}
    parted -s ${SDIMG} set 1 boot on
    parted -s ${SDIMG} unit KiB mkpart primary ext4 ${ROOTFS_START} 100%
    parted ${SDIMG} print

    do_copy_abc_files

    mkfs.vfat -F 32 -n "${BOOTDD_VOLUME_ID}" -S 512 -C ${WORKDIR}/boot.img ${BOOT_BLOCKS}
    mcopy -v -i ${WORKDIR}/boot.img -s ${DEPLOY_DIR_IMAGE}/${OUTPUT_DIR_NAME}/* ::/

    dd if=${WORKDIR}/boot.img of=${SDIMG} conv=notrunc seek=${BOOT_OFFSET_BLOCKS} bs=512
    rm -fv ${WORKDIR}/boot.img
}

addtask mk_abc_image after virtual/kernel:do_deploy u-boot:do_deploy do_image_squashfs_xz before do_image_complete

do_mk_abc_image[depends] += "${@' '.join('%s-native:do_populate_sysroot' % r for r in ('parted', 'gptfdisk', 'dosfstools', 'mtools'))}"
do_mk_abc_image[depends] += "bootfiles:do_deploy"
do_mk_abc_image[dirs] += "${DEPLOY_DIR_IMAGE}/${OUTPUT_DIR_NAME}"

