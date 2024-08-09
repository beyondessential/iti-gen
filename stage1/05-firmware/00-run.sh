#!/bin/bash -e

# params for the boot firmware
cat <<EOF >> "${ROOTFS_DIR}/boot/firmware/config.txt"
dtparam=i2c_arm=on
dtparam=spi=on
dtparam=pciex1
dtparam=pciex1_gen=3
EOF

# boot script for the minimal image only (removed in next stage)
# that sets eeprom settings for hardware options (boot order, pcie, halt)
# order: SD as override, NVMe as primary, no USB boot
cat <<EOF >> "${ROOTFS_DIR}/usr/local/bin/iti-boot-config"
rpi-eeprom-config | sed -E '/(POWER_OFF_ON_HALT|BOOT_ORDER|PCIE_PROBE|PSU_MAX_CURRENT)=.+/d' > /tmp/eeprom.txt
echo 'POWER_OFF_ON_HALT=1' >> /tmp/eeprom.txt
echo 'BOOT_ORDER=0xf61' >> /tmp/eeprom.txt
echo 'PCIE_PROBE=1' >> /tmp/eeprom.txt
echo 'PSU_MAX_CURRENT=5000' >> /tmp/eeprom.txt
rpi-eeprom-config --apply /tmp/eeprom.txt
rm -f /tmp/eeprom.txt
EOF

cat <<EOF >> "${ROOTFS_DIR}/etc/systemd/system/iti-boot-config.service"
[Unit]
Description=Iti Boot Config

[Service]
Type=oneshot
ExecStart=/usr/local/bin/iti-boot-config
RemainAfterExit=true
EOF

cat <<EOF >> "${ROOTFS_DIR}/etc/systemd/system/iti-boot-config.timer"
[Unit]
Description=Run iti boot config on every boot

[Timer]
OnBootSec=5sec
OnUnitActiveSec=1min

[Install]
WantedBy=timers.target
EOF

on_chroot << EOF
systemctl enable iti-boot-config.timer
EOF
