#!/bin/sh

ROOT=$(readlink -e $(dirname $0))
. $ROOT/.env

#env

if [ "$GITHUB_ACTIONS" = "true" ]; then
  SINGLE_BRANCH='--single-branch'
fi

[ ! -d $BUILD_FOLDER ]&& mkdir -p "$BUILD_FOLDER"

cd $BUILD_FOLDER

if [ ! -d "$OPENWRT_FOLDER/.git" ]; then
   git clone -b $release $SINGLE_BRANCH  https://git.openwrt.org/openwrt/openwrt.git $OPENWRT_FOLDER
   cd $OPENWRT_FOLDER
else
   cd $OPENWRT_FOLDER
   git pull
fi
