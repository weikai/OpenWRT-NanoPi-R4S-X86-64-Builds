#!/bin/sh

ROOT=$(dirname $(dirname $(readlink -f $0)))

. $ROOT/.env

cd $OPENWRT_FOLDER


#make menuconfig

# generate new seed and patch if updated
./scripts/diffconfig.sh > seed.tmp

if grep 'CONFIG_TARGET_.*r4s=y' seed.tmp > /dev/null; then
  echo "Building R4S image"
  if [ -n "$(diff $SEED seed.tmp)" ]; then
     cp seed.tmp ${SEED}.new
  fi
elif grep 'CONFIG_TARGET_.*x86_64=y' seed.tmp > /dev/null; then
  echo "Building x86_64 image"
  diff -u ${SEED} seed.tmp > seed_patch.tmp
  if [ -n "$(diff $ROOT/seed/r4s_x86_64.patch seed_patch.tmp)" ]; then
     cp seed_patch.tmp $ROOT/seed/r4s_x86_64.patch.new
  fi

else
  echo "Wrong target architecture"
  exit 1
fi




make -j $(nproc)  && \
find ./bin/targets -name 'config.buildinfo'|xargs -I{} sh -c 'file={}; target=$(echo $file| sed -r "s|.*/targets/(.+?)/.*|\1|"|sed -s "s|/.*||");mv $file $(dirname $file)/config-${target}.buildinfo'
