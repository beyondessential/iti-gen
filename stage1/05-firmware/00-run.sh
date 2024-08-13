#!/bin/bash -e

# params for the boot firmware
cat files/config.txt >> "${ROOTFS_DIR}/boot/firmware/config.txt"

# boot script for the minimal image only (removed in next stage)
# that sets eeprom settings for hardware options (boot order, pcie, halt)
# order: SD as override, NVMe as primary, no USB boot
install -vm755 files/iti-boot-config "${ROOTFS_DIR}/usr/local/bin/"
install -vm644 files/iti-boot-config.* "${ROOTFS_DIR}/etc/systemd/system/"
on_chroot << EOF
systemctl enable iti-boot-config.timer
EOF
