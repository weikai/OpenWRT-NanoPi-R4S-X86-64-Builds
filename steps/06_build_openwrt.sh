#!/bin/sh
ROOT=$(readlink -e $(dirname $0))
. $ROOT/.env

cd $OPENWRT_FOLDER


#make menuconfig
make -j $(nproc)  && \
find ./bin/targets -name 'config.buildinfo'|xargs -I{} sh -c 'file={}; target=$(echo $file| sed -r "s|.*/targets/(.+?)/.*|\1|"|sed -s "s|/.*||");mv $file $(dirname $file)/config_${target}.buildinfo'
