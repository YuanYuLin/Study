
mk_empty_dir_image() {
    image_dst="${DEPLOY_DIR_IMAGE}/abc"
    image_size_kb=${FLASH_SIZE}
    mkdir -p $image_dst

    cp ${DEPLOY_DIR_IMAGE}/image-u-boot ${image_dst}/bootloader
    cp ${DEPLOY_DIR_IMAGE}/image-kernel ${image_dst}/kernel
    cp ${DEPLOY_DIR_IMAGE}/image-rofs   ${image_dst}/rootfs
}

python do_post_commands() {
    '''
    abc = os.path.join(d.getVar('DEPLOY_DIR_IMAGE', True))
    abcd = d.getVar('FLASH_SIZE', True)
    bb.debug("Example '%s' - %s bytes!" % (abc, abcd))
    '''
    #execute shell
    bb.build.exec_func("mk_empty_dir_image", d)
}

addtask do_post_commands after do_image_complete before do_populate_lic_deploy
