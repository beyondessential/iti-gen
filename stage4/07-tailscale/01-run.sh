#!/bin/bash -e

install -vm600 files/*.asc "${ROOTFS_DIR}/etc/apt/keyrings/"

cat >"${ROOTFS_DIR}/etc/apt/sources.list.d/tailscale.list" <<TSDEB
deb [signed-by=/etc/apt/keyrings/tailscale.asc] https://pkgs.tailscale.com/stable/debian $RELEASE main
TSDEB

on_chroot << EOF
  apt update
EOF
