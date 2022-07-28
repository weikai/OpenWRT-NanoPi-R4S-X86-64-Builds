#!/bin/sh

ROOT=$(dirname $(dirname $(readlink -f $0)))

. $ROOT/.env

cd $OPENWRT_FOLDER


[ -f .config ]&&mv .config .config.bak
cp $ROOT/seed/r4s.seed .config;patch .config < $ROOT/seed/r4s_x86_64.patch;make defconfig

./scripts/diffconfig.sh > $ROOT/seed/x86.seed.new
diff -u $ROOT/seed/r4s.seed $ROOT/seed/x86.seed.new > $ROOT/seed/r4s_x86_64.patch.new
