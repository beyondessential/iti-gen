#!/bin/bash -e

# script for the minimal image only (removed in next stage)
install -vm755 files/iti-lcd-good "${ROOTFS_DIR}/usr/local/bin/"
install -vm644 files/iti-lcd-good.* "${ROOTFS_DIR}/etc/systemd/system/"
on_chroot << EOF
systemctl enable iti-lcd-good.timer
EOF
