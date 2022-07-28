#!/bin/sh
ROOT=$(dirname $(dirname $(readlink -f $0)))

. $ROOT/.env

cd $OPENWRT_FOLDER

# Update the feeds
scripts/feeds update -a
scripts/feeds install -a
