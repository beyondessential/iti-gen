#!/bin/bash -e

on_chroot << EOF
  wget https://github.com/45Drives/cockpit-navigator/releases/download/v0.5.10/cockpit-navigator_0.5.10-1focal_all.deb
  dpkg -i cockpit-navigator_0.5.10-1focal_all.deb
  rm cockpit-navigator_0.5.10-1focal_all.deb

  wget https://github.com/ocristopfer/cockpit-sensors/releases/latest/download/cockpit-sensors.deb
  dpkg -i cockpit-sensors.deb
  rm cockpit-sensors.deb
EOF
