#!/bin/sh

ROOT=$(readlink -e $(dirname $0))
. $ROOT/.env

[ ! -d $BUILD_FOLDER ]&& mkdir -p "$BUILD_FOLDER"

cd $BUILD_FOLDER

if [ ! -d "$OPENWRT_FOLDER/.git" ]; then
   git clone -b $release  --single-branch https://git.openwrt.org/openwrt/openwrt.git $OPENWRT_FOLDER
   cd $OPENWRT_FOLDER
else
   cd $OPENWRT_FOLDER
   git pull
fi
