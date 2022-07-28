#!/bin/sh

ROOT=$(dirname $(dirname $(readlink -f $0)))

. $ROOT/.env

cd $OPENWRT_FOLDER


#make menuconfig
make -j $(nproc)  && \
find ./bin/targets -name 'config.buildinfo'|xargs -I{} sh -c 'file={}; target=$(echo $file| sed -r "s|.*/targets/(.+?)/.*|\1|"|sed -s "s|/.*||");mv $file $(dirname $file)/config-${target}.buildinfo'
