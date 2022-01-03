#!/bin/sh
ROOT=$(readlink -e $(dirname $0))
. $ROOT/.env

cd $OPENWRT_FOLDER
pwd



# download linux
make target/linux/prepare

#apply reboot patch
dir=$(find build_dir/target-aarch64_generic_musl/linux-rockchip_armv8 -maxdepth 1 -type d -name 'linux-5.*')
#curl -s https://raw.githubusercontent.com/immortalwrt/immortalwrt/master/target/linux/rockchip/patches-5.4/105-mmc-core-set-initial-signal-voltage-on-power-off.patch | \
#patch -N -p1 -d $dir

patch -N -p1 -i $ROOT/patches/105-mmc-core-set-initial-signal-voltage-on-power-off.patch -d $dir

