#!/bin/bash 

set -ex

INSTALL_FOLDER=Pharo7.0-32bit-iot-$(date +%Y%m%d%H%M)
#PharoVM 7.0 for Linux 32bit: 
wget "https://files.pharo.org/get-files/70/pharo-linux-stable.zip"
unzip pharo-linux-stable.zip -d $INSTALL_FOLDER
rm -rf pharo-linux-stable.zip
cd $INSTALL_FOLDER 
#Pharo image 32bit:
wget "https://files.pharo.org/get-files/70/pharo.zip"
unzip -o pharo.zip
rm -rf pharo.zip
#ArmVM:
wget "http://files.pharo.org/vm/pharo-spur32/linux/armv6/latest.zip"
unzip -o latest.zip
rm -rf latest.zip
