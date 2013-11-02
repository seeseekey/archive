#!/bin/sh

sshfsConnectionString="user@example.org";
sshfsPassword="secret";
sshfsMountPoint="/mnt/backup/";

# mount sshfs
echo $sshfsPassword | sshfs $sshfsConnectionString:/ $sshfsMountPoint -o workaround=rename -o password_stdin

# start backup
rdiff-backup /etc/ ${sshMountPoint}etc/
rdiff-backup /var/ ${sshMountPoint}var/

# unmount all
umount $sshfsMountPoint;