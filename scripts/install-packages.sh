#!/bin/bash 

set -ex

TEMP_RASP_SER=pharo7-iot-rasp-ser
TEMP_RASP_SERCLI=pharo7-iot-rasp-ser-cli
TEMP_MULTI_SERCLI=pharo7-iot-multi-ser-cli

# Pharo 7 IoT Raspberry Server
unzip -q tmp/pharo-linux-stable.zip -d $TEMP_RASP_SER
unzip -qo tmp/pharo.zip -d $TEMP_RASP_SER
sudo $TEMP_RASP_SER/pharo --nodisplay $TEMP_RASP_SER/Pharo7*.image eval "
Iceberg enableMetacelloIntegration: true.
Metacello new
  baseline: 'PharoThings';
  repository: 'github://pharo-iot/PharoThings/src';
  load: #(RemoteDevServer Raspberry).
Smalltalk saveSession. 
"  > /dev/null 2>&1

# Pharo 7 IoT Raspberry Server Client
cp -r $TEMP_RASP_SER/ $TEMP_RASP_SERCLI
sudo $TEMP_RASP_SERCLI/pharo --nodisplay $TEMP_RASP_SERCLI/Pharo7*.image eval "
Iceberg enableMetacelloIntegration: true.
Metacello new
  baseline: 'PharoThings';
  repository: 'github://pharo-iot/PharoThings/src';
  load: 'RemoteDev'.
Smalltalk saveSession. 
"  > /dev/null 2>&1

# Pharo 7 IoT Multiplataform Server Client
cp -r $TEMP_RASP_SERCLI/ $TEMP_MULTI_SERCLI
LIB_FOLDER=$(ls $TEMP_MULTI_SERCLI/lib/pharo/)
mv $TEMP_MULTI_SERCLI/lib/pharo/$LIB_FOLDER/pharo $TEMP_MULTI_SERCLI/lib/pharo/$LIB_FOLDER/pharo-32
unzip -qo tmp/pharo64-linux-stable.zip -d $TEMP_MULTI_SERCLI
cp $TEMP_MULTI_SERCLI/lib/pharo/$LIB_FOLDER/pharo $TEMP_MULTI_SERCLI/lib/pharo/$LIB_FOLDER/pharo-64
unzip -qo tmp/pharo64.zip -d $TEMP_MULTI_SERCLI
sudo $TEMP_MULTI_SERCLI/pharo --nodisplay $TEMP_MULTI_SERCLI/Pharo7*64*.image eval "
Iceberg enableMetacelloIntegration: true.
Metacello new
  baseline: 'PharoThings';
  repository: 'github://pharo-iot/PharoThings/src';
  load: 'RemoteDev'.
Metacello new
  baseline: 'PharoThings';
  repository: 'github://pharo-iot/PharoThings/src';
  load: #(RemoteDevServer Raspberry).
Smalltalk saveSession. 
"  > /dev/null 2>&1

# Adding VMs
# ArmVM:
TEMP_ARM_VM=tmp/temp-arm-vm
unzip -qo tmp/latest.zip -d $TEMP_ARM_VM
mv $TEMP_ARM_VM/lib/pharo/5* $TEMP_ARM_VM/lib/pharo/$LIB_FOLDER
cp -rf $TEMP_ARM_VM/lib/pharo/$LIB_FOLDER/pharo $TEMP_ARM_VM/lib/pharo/$LIB_FOLDER/pharo-arm
cp -rf $TEMP_ARM_VM/* $TEMP_MULTI_SERCLI/
cp -rf $TEMP_ARM_VM/* $TEMP_RASP_SERCLI/
cp -rf $TEMP_ARM_VM/* $TEMP_RASP_SER/
 
# Windows32 VM
unzip -qo tmp/pharo-win-stable.zip -d $TEMP_MULTI_SERCLI/

# Mac32 VM
unzip -qo tmp/pharo-mac-stable.zip -d tmp
ls -la tmp
ls -la tmp/Pharo.app
mv tmp/Pharo.app $TEMP_MULTI_SERCLI/Pharo7.app
ls -la tmp

# Clean up temp folders
sudo rm -rf tmp