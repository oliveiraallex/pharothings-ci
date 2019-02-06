#!/bin/bash 

set -ex

# PharoVM 7.0 for Linux 32bit: 
wget "https://files.pharo.org/get-files/70/pharo-linux-stable.zip"
unzip pharo-linux-stable.zip -d Pharo7.0-32bit-iot
rm -rf pharo-linux-stable.zip
cd Pharo7.0-32bit-iot 
# Pharo image 32bit:
wget "https://files.pharo.org/get-files/70/pharo.zip"
unzip -o pharo.zip
rm -rf pharo.zip
