#!/bin/bash -e

curl -LO "https://tools.ops.tamanu.io/bestool/${BESTOOL_VERSION}/aarch64-unknown-linux-musl/bestool"
install -vm755 bestool "${ROOTFS_DIR}/usr/local/bin/"
rm bestool

git clone https://github.com/beyondessential/bestool
pushd bestool
git switch --detach "v${BESTOOL_VERSION}"
cd services
install -vm644 *.service "${ROOTFS_DIR}/etc/systemd/system/"
rm *.service
install -vm755 * "${ROOTFS_DIR}/usr/local/bin/"
popd
rm -rf bestool

echo 'i2c-dev' > "${ROOTFS_DIR}/etc/modules-load.d/modules.conf"

on_chroot << EOF
systemctl enable iti-lcd-server.service iti-battery.service
EOF
