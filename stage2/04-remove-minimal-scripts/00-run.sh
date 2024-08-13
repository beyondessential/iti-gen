#!/bin/bash -e

# remove boot script (it's for the minimal image only)
on_chroot << EOF
systemctl disable iti-boot-config.timer || true
EOF
rm -f "${ROOTFS_DIR}/usr/local/bin/iti-boot-config"
rm -f "${ROOTFS_DIR}/etc/systemd/system/iti-boot-config.service"
rm -f "${ROOTFS_DIR}/etc/systemd/system/iti-boot-config.timer"

# remove lcd-good script (it's for the minimal image only)
on_chroot << EOF
systemctl disable iti-lcd-good.timer || true
EOF
rm -f "${ROOTFS_DIR}/usr/local/bin/iti-lcd-good"
rm -f "${ROOTFS_DIR}/etc/systemd/system/iti-lcd-good.service"
rm -f "${ROOTFS_DIR}/etc/systemd/system/iti-lcd-good.timer"
