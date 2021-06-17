#!/bin/sh
ROOT=$(readlink -e $(dirname $0))
. $ROOT/.env

cd $OPENWRT_FOLDER


#make menuconfig
make -j $(nproc)