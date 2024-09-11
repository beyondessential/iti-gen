#!/bin/bash -e

on_chroot << EOF
systemctl enable iti-{addresses,lcd-wifi,localtime,sparks,temperature}.service
EOF
