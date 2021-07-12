#!/bin/sh


#ubuntu bionic build  requirments
#openwrt ubuntu prerequirments
#RUN apt-get install -y install build-essential ccache ecj fastjar file g++ gawk \
#gettext git java-propose-classpath libelf-dev libncurses5-dev \
#libncursesw5-dev libssl-dev python python2.7-dev python3 unzip wget \
#python3-distutils python3-setuptools rsync subversion swig time \
#xsltproc zlib1g-dev

ROOT=$(readlink -e $(dirname $0))


if [ "$1" = 'r4s' ] || [ "$1" = 'x86' ] || [ "$1" = 'x86_64' ] || [ "$1" = 'all' ]; then
  build=$1
else
  echo 'USAGE: init [r4s|x86|x86_64|all]'
  exit
fi

#Checkout code
$ROOT/steps/01_checkout_code.sh

#Update feeds
$ROOT/steps/02_update_feed.sh

#Apply patch
#$ROOT/steps/03_apply_patch.sh

# build r4s
if [ "$build" = 'r4s' ] || [ "$build" = 'all' ]; then
  #Setup config
  $ROOT/steps/04_setup_config.sh

  #Apply post config patch
  $ROOT/steps/05_apply_post_config_patch.sh

  #build
  [ "$2" != 'nobuild' ]&&$ROOT/steps/06_build_openwrt.sh
  
fi

#./build/openwrt/scripts/diffconfig.sh

#build x86 
if [ "$build" = 'x86' ] || [ "$build" = 'x86_64' ] || [ "$build" = 'all' ]; then

  #Setup config
  $ROOT/steps/04_setup_config_x86.sh
  
  #build
  [ "$2" != 'nobuild' ]&&$ROOT/steps/06_build_openwrt.sh

fi


