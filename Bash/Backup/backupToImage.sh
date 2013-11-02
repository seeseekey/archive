#!/bin/sh

sshfsConnectionString="user@example.org";
sshfsPassword="secret";
sshfsMountPoint="/mnt/backup/";

imagePath="/mnt/backup/backup.img";
imageMountPoint="/mnt/backup-image/";

# mount sshfs
echo $sshfsPassword | sshfs $sshfsConnectionString:/ $sshfsMountPoint -o workaround=rename -o password_stdin

# mount image
mount -o loop $imagePath $imageMountPoint

# start backup
rdiff-backup /etc/ ${imageMountPoint}etc/
rdiff-backup /var/ ${imageMountPoint}var/

# unmount all
umount $imageMountPoint;
umount $sshfsMountPoint;