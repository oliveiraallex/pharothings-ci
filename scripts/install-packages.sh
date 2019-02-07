#!/bin/bash 

set -ex

cd Pharo7.0-32bit-iot
./pharo --nodisplay Pharo7*.image eval "
Iceberg enableMetacelloIntegration: true.
Metacello new
  baseline: 'PharoThings';
  repository: 'github://pharo-iot/PharoThings/src';
  load: #(RemoteDevServer Raspberry).
Metacello new
  baseline: 'PharoThings';
  repository: 'github://pharo-iot/PharoThings/src';
  load: 'RemoteDev'.
Smalltalk saveSession. 
"

# ArmVM:
wget "http://files.pharo.org/vm/pharo-spur32/linux/armv6/latest.zip"
unzip -o latest.zip
rm -rf latest.zip