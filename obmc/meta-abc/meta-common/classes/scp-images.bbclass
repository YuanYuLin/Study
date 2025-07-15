scp_images() {
    # '''
    # TODO
    #   Check SSHFS mount point before copy files.
    # '''
    SSHFS_DIR="/data/obmc/sshfs_pi"
    cp -v ${DEPLOY_DIR_IMAGE}/image-rofs   ${SSHFS_DIR}/rootfs.squashfs.rpi1a
    cp -v ${DEPLOY_DIR_IMAGE}/image-kernel ${SSHFS_DIR}/fitimage.rpi1a
}

python do_post_commands() {
    #execute shell
    bb.build.exec_func("scp_images", d)
}

addtask do_post_commands after do_image_complete before do_populate_lic_deploy

