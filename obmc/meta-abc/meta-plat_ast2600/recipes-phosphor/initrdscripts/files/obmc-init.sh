#!/bin/sh

fslist="proc sys dev run"
rodir=/run/initramfs/ro
rwdir=/run/initramfs/rw
upper=$rwdir/cow
work=$rwdir/work
rootdir=/root
ROOTFS=/rootfs.squashfs.ast2600

cd /

mkdir -p $fslist
mount dev dev -tdevtmpfs
mount sys sys -tsysfs
mount proc proc -tproc
if ! grep run proc/mounts
then
	mount tmpfs run -t tmpfs -o mode=755,size=50M,nodev
fi

mkdir -p $rodir $rwdir

cp -rp init shutdown update whitelist bin sbin usr lib etc var run/initramfs

export_cmdline_var() {
    for arg in $(cat /proc/cmdline); do
        case "$arg" in
        BOOT=*)
            export "$arg"
            ;;
        esac
    done
}

prepare_rootfs_tftp() {
    ip link set lo up
    sleep 3
    ip addr add 192.168.70.100/24 dev eth0
    ip link set eth0 up
    echo "Downloading '$ROOTFS' from '192.168.70.254' ..."

    tftp -g -r $ROOTFS -l $ROOTFS 192.168.70.254
    ip link set eth0 down
    ip addr del 192.168.70.100/24 dev eth0
}

prepare_rootfs_emmc() {
    echo "Mounting /dev/mmcblk0p1 to /mnt ..."
    mkdir -p /mnt
    mount -t vfat /dev/mmcblk0p1 /mnt
    cp -v /mnt/$ROOTFS $ROOTFS

    umount /mnt
    echo "Unmounted"
}

mount_rootfs() {
    roopts=ro
    rofst=squashfs
    rodev=$ROOTFS
    mount "$rodev" $rodir -t $rofst -o $roopts

    mount -t tmpfs -o mode=755,size=50M tmpfs $rwdir
    mkdir -p $upper
    mkdir -p $work

    mkdir -p $rootdir
    mount -t overlay -o lowerdir=$rodir,upperdir=$upper,workdir=$work cow $rootdir
}

export_cmdline_var

if [ "$BOOT" == "tftp" ];
then
    prepare_rootfs_tftp
elif [ "$BOOT" == "mmc" ];
then
    prepare_rootfs_emmc
else
    exec /bin/sh
fi

mount_rootfs

for f in $fslist
do
    mount --move "$f" "root/$f"
done

exec switch_root -c /dev/console $rootdir /sbin/init

