#!/bin/bash -e

# remove boot script (it's for the minimal image only)
on_chroot << EOF
systemctl disable iti-boot-config.timer
EOF
rm -f "${ROOTFS_DIR}/usr/local/bin/iti-boot-config"
rm -f "${ROOTFS_DIR}/etc/systemd/system/iti-boot-config.service"
rm -f "${ROOTFS_DIR}/etc/systemd/system/iti-boot-config.timer"
