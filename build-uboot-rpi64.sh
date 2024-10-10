#!/bin/bash
# Copyright 2024 Northern.tech AS
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.

# Script to generate Mender integration binaries for Raspberry Pi boards
#
# Files that will be packaged:
#
#     - u-boot.bin
#     - fw_printenv
#     - fw_env.config
#
# NOTE! This script is not necessarily well tested and the main purpose
# is to provide an reference on how the current integration binaries where
# generated.

set -e

function usage() {
    echo "./$(basename $0) <defconfig> <board name>"
}

if [ -z "$1" ] || [ -z "$2" ]; then
    usage
    exit 1
fi

# Availabile defconfigs:
#
#    - rpi_3_defconfig
#    - rpi_4_defconfig
#    - rpi_arm64_defconfig
#
rpi_defconfig=$1
rpi_board=$2

echo "$rpi_board: starting"

# ARM 64bit build
export CROSS_COMPILE=aarch64-linux-gnu-
export ARCH=aarch64

# Test if the toolchain is actually installed
${CROSS_COMPILE}gcc --version

UBOOT_MENDER_BRANCH=2024.04

# Clean-up old builds
rm -rf uboot-mender

echo "$rpi_board: getting source"

git clone https://github.com/mendersoftware/uboot-mender.git -b mender-rpi-${UBOOT_MENDER_BRANCH}
cd uboot-mender

echo "$rpi_board: compiling source"

make ${rpi_defconfig}
make -j $(nproc)
make -j $(nproc) envtools

echo "$rpi_board: finalizing env tools"

cat <<- EOF > fw_env.config
/dev/mmcblk0 0x400000 0x4000
/dev/mmcblk0 0x800000 0x4000
EOF

echo "$rpi_board: packing up artifacts"

mkdir integration-binaries
cp u-boot.bin tools/env/fw_printenv fw_env.config integration-binaries/
git log --graph --pretty=oneline -15 > integration-binaries/uboot-git-log.txt
cd integration-binaries

# Availabile boards:
#
#    - raspberrypi3_64
#    - raspberrypi4_64
#    - raspberrypi_arm64?
#
tar czvf ${rpi_board}-${UBOOT_MENDER_BRANCH}.tar.gz ./*
cd -

echo "$rpi_board: done"

