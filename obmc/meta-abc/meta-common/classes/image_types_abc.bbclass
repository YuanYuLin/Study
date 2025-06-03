inherit image_types

IMAGE_CMD:abc () {
    #bbnote "Creating abc image... ${IMGDEPLOYDIR}"
    rm -fv ${IMGDEPLOYDIR}/*.sdimg
    rm -fv ${IMGDEPLOYDIR}/*.${IMAGE_BASETYPE}

    ####
    bbnote "Creating ${IMAGE_BASETYPE}"
    ls ${DEPLOY_DIR_IMAGE}
    #tar czf "${IMGDEPLOYDIR}/${IMAGE_NAME}.abc" -C "${IMAGE_ROOTFS}" .
    mkdir -p ${IMGDEPLOYDIR}
    mksquashfs ${IMAGE_ROOTFS} ${IMGDEPLOYDIR}/${IMAGE_NAME}.${IMAGE_BASETYPE} \
        -comp xz -noappend -no-progress

    ln -sf ${IMAGE_NAME}.${IMAGE_BASETYPE} ${IMGDEPLOYDIR}/${IMAGE_LINK_NAME}.${IMAGE_BASETYPE}

    ####
    bbnote "Create bootfiles"
    #install -d ${DEPLOY_DIR_IMAGE}/bootfiles
    #cp -a ${DEPLOY_DIR_IMAGE}/bootfiles/* ${DEPLOY_DIR_IMAGE}/bootfiles/

    ####
    bbnote "Creating emmc"
    SDIMG="${IMGDEPLOYDIR}/${IMAGE_NAME}.sdimg"
    SDIMG_SIZE=65536

    BOOT_START=4096
    BOOT_END=61440
    BOOT_BLOCKS=114688 #((BOOT_END - BOOT_START)*1024)/512
    ROOTFS_START=${BOOT_END}
    BOOTDD_VOLUME_ID="abc"

    dd if=/dev/zero of=${SDIMG} bs=1024 count=0 seek=${SDIMG_SIZE}

    parted -s ${SDIMG} mklabel msdos
    parted -s ${SDIMG} unit KiB mkpart primary fat32 ${BOOT_START} ${BOOT_END}
    parted -s ${SDIMG} set 1 boot on
    parted -s ${SDIMG} unit KiB mkpart primary ext4 ${ROOTFS_START} 100%
    parted ${SDIMG} print

    #BOOT_BLOCKS=$(((BOOT_END - BOOT_START) * 1024 / 512))
    mkfs.vfat -F 32 -n "${BOOTDD_VOLUME_ID}" -S 512 -C ${WORKDIR}/boot.img ${BOOT_BLOCKS}
    mcopy -v -i ${WORKDIR}/boot.img -s ${DEPLOY_DIR_IMAGE}/u-boot.bin ::/
    cp -v ${DEPLOY_DIR_IMAGE}/fitImage-${INITRAMFS_IMAGE}-${MACHINE}-${MACHINE} ${DEPLOY_DIR_IMAGE}/fitImage
    mcopy -v -i ${WORKDIR}/boot.img -s ${DEPLOY_DIR_IMAGE}/fitImage ::/
    cp -v ${IMGDEPLOYDIR}/${IMAGE_NAME}.${IMAGE_BASETYPE} ${DEPLOY_DIR_IMAGE}/rootfs.squashfs
    mcopy -v -i ${WORKDIR}/boot.img -s ${DEPLOY_DIR_IMAGE}/rootfs.squashfs ::/
    mcopy -v -i ${WORKDIR}/boot.img -s ${DEPLOY_DIR_IMAGE}/bootfiles/* ::/

    #BOOT_OFFSET_BLOCKS=$((BOOT_START * 1024 / 512))
    BOOT_OFFSET_BLOCKS=8192
    dd if=${WORKDIR}/boot.img of=${SDIMG} conv=notrunc seek=${BOOT_OFFSET_BLOCKS} bs=512
    rm -fv ${WORKDIR}/boot.img
}

#IMAGE_TYPEDEP:abc = "squashfs-tools-native xz-native"

do_image_abc[depends] += "parted-native:do_populate_sysroot"
do_image_abc[depends] += "mtools-native:do_populate_sysroot"
do_image_abc[depends] += "dosfstools-native:do_populate_sysroot"
do_image_abc[depends] += "bootfiles:do_deploy"

