#!/bin/sh

fslist="proc sys dev run mnt"
rodir=run/initramfs/ro
rwdir=run/initramfs/rw
upper=$rwdir/cow
work=$rwdir/work
ROOTFS=/rootfs.squashfs.rpi

cd /

mkdir -p $fslist
mount dev dev -tdevtmpfs
mount sys sys -tsysfs
mount proc proc -tproc
if ! grep run proc/mounts
then
	mount tmpfs run -t tmpfs -o mode=755,nodev
fi

mkdir -p $rodir $rwdir

cp -rp init shutdown update whitelist bin sbin usr lib etc var run/initramfs

prepare_rootfs_tftp() {
    ifconfig lo up
    sleep 2
    ifconfig eth0 up
    ifconfig eth0 192.168.70.200
    echo "Downloading '$ROOTFS' from '192.168.70.254' ..."

    tftp -g -r $ROOTFS -l $ROOTFS 192.168.70.254
}

prepare_rootfs_emmc() {
# Mount EMMC block
echo "Mounting /dev/mmcblk0p1 to /mnt ..."
mount -t vfat /dev/mmcblk0p1 /mnt
cp -v /mnt/rootfs.squashfs /

# Unmount
umount /mnt
}

mount_rootfs() {
roopts=ro
rofst=squashfs
rodev=$ROOTFS
mount "$rodev" $rodir -t $rofst -o $roopts

mount -t tmpfs -o mode=755 tmpfs $rwdir
mkdir -p $upper
mkdir -p $work

mount -t overlay overlay -o lowerdir=$rodir,upperdir=$upper,workdir=$work  /root
}

switch_rootfs() {
init=/sbin/init
exec switch_root /root $init
}

debug_takeover() {
exec /bin/sh
}

#debug_takeover

#prepare_rootfs_emmc
prepare_rootfs_tftp
mount_rootfs
switch_rootfs
