#!/bin/bash -e
install -m 600 files/020_iti-nopasswd "${ROOTFS_DIR}/etc/sudoers.d/"
