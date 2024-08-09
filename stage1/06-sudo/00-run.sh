#!/bin/bash -e

if [ -f "${ROOTFS_DIR}/etc/sudoers.d/010_pi-nopasswd" ]; then
  sed -i "s/^pi /$FIRST_USER_NAME /" "${ROOTFS_DIR}/etc/sudoers.d/010_pi-nopasswd"
  mv "${ROOTFS_DIR}/etc/sudoers.d/010_pi-nopasswd" "${ROOTFS_DIR}/etc/sudoers.d/010_$FIRST_USER_NAME-nopasswd"
fi
