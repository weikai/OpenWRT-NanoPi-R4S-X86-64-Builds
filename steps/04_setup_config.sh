#!/bin/sh

ROOT=$(dirname $(dirname $(readlink -f $0)))

. $ROOT/.env

cd $OPENWRT_FOLDER



[ -f .config ]&&mv .config .config.bak
cp $SEED .config && make defconfig

## make menuconfig
#./scripts/diffconfig.sh > $ROOT/seed/r4s.seed.new
