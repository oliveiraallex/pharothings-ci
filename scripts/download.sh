#!/bin/bash 

set -ex

FILE_PHARO=Pharo7.0-32bit-iot

# PharoVM 7.0 for Linux 32bit: 
wget "https://files.pharo.org/get-files/70/pharo-linux-stable.zip"
unzip pharo-linux-stable.zip -d $FILE_PHARO
rm -rf pharo-linux-stable.zip
cd $FILE_PHARO
# Pharo image 32bit:
wget "https://files.pharo.org/get-files/70/pharo.zip"
unzip -o pharo.zip
rm -rf pharo.zip