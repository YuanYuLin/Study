scp_images() {
    # '''
    # TODO
    #   Check SSHFS mount point before copy files.
    # 
    # SSHFS: sshfs pi@x.x.x.x:/srv/tftp /data/obmc/sshfs_pi
    # '''
    SSHFS_DIR="/data/obmc/sshfs_pi"
    if grep -qs "sshfs_pi" /proc/mounts; then
        bbwarn "sshfs $SSHFS_DIR mounted!"
    else
        bbfatal "sshfs $SSHFS_DIR NOT mounted!"
    fi
    cp -v ${DEPLOY_DIR_IMAGE}/image-rofs   ${SSHFS_DIR}/rootfs.squashfs.${SCP_IMAGE_POSTFIX}
    cp -v ${DEPLOY_DIR_IMAGE}/image-kernel ${SSHFS_DIR}/fitimage.${SCP_IMAGE_POSTFIX}
}

python do_post_commands() {
    #execute shell
    bb.build.exec_func("scp_images", d)
}

addtask do_post_commands after do_image_complete before do_populate_lic_deploy

