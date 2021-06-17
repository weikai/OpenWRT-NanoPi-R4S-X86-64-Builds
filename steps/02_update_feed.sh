#!/bin/sh
ROOT=$(readlink -e $(dirname $0))
. $ROOT/.env

cd $OPENWRT_FOLDER

# Update the feeds
scripts/feeds update -a
scripts/feeds install -a
