#!/bin/sh
ROOT=$(readlink -e $(dirname $0))
. $ROOT/.env

cd $OPENWRT_FOLDER



[ -f .config ]&&mv .config .config.bak
cp $ROOT/seed/r4s.seed .config && make defconfig
