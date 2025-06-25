OUTPUT_DIR_NAME ?= "abc"

do_copy_abc_files() {
    cp -v ${DEPLOY_DIR_IMAGE}/u-boot.bin ${DEPLOY_DIR_IMAGE}/${OUTPUT_DIR_NAME}/u-boot.bin
    cp -v ${DEPLOY_DIR_IMAGE}/fitImage-${INITRAMFS_IMAGE}-${MACHINE}-${MACHINE} ${DEPLOY_DIR_IMAGE}/${OUTPUT_DIR_NAME}/fitImage
    cp -v ${IMGDEPLOYDIR}/${IMAGE_LINK_NAME}.${IMAGE_BASETYPE} ${DEPLOY_DIR_IMAGE}/${OUTPUT_DIR_NAME}/rootfs.squashfs
}

