#!/bin/bash 

set -ex

TEMP_RASP_SER=pharo7-iot-rasp-ser
TEMP_RASP_SERCLI=pharo7-iot-rasp-ser-cli
TEMP_MULTI_SERCLI=pharo7-iot-multi-ser-cli

# Pharo 7 IoT Raspberry Server
unzip -q tmp/pharo-linux-stable.zip -d $TEMP_RASP_SER
unzip -qo tmp/pharo.zip -d $TEMP_RASP_SER
$TEMP_RASP_SER/pharo --nodisplay $TEMP_RASP_SER/Pharo7*.image eval "
Iceberg enableMetacelloIntegration: true.
Metacello new
  baseline: 'PharoThings';
  repository: 'github://pharo-iot/PharoThings/src';
  load: #(RemoteDevServer Raspberry).
Smalltalk saveSession. 
"

# Pharo 7 IoT Raspberry Server Client
cp -r $TEMP_RASP_SER/ $TEMP_RASP_SERCLI
$TEMP_RASP_SERCLI/pharo --nodisplay $TEMP_RASP_SERCLI/Pharo7*.image eval "
Iceberg enableMetacelloIntegration: true.
Metacello new
  baseline: 'PharoThings';
  repository: 'github://pharo-iot/PharoThings/src';
  load: 'RemoteDev'.
Smalltalk saveSession. 
"

# Pharo 7 IoT Multiplataform Server Client
cp -r $TEMP_RASP_SERCLI/ $TEMP_MULTI_SERCLI
LIB_FOLDER=$(ls $TEMP_MULTI_SERCLI/lib/pharo/)
mv $TEMP_MULTI_SERCLI/lib/pharo/$LIB_FOLDER/pharo $TEMP_MULTI_SERCLI/lib/pharo/$LIB_FOLDER/pharo-32
unzip -qo tmp/pharo64-linux-stable.zip
cp pharo64-linux-stable/* $TEMP_MULTI_SERCLI/
cp $TEMP_MULTI_SERCLI/lib/pharo/5*/pharo $TEMP_MULTI_SERCLI/lib/pharo/5*/pharo-64
unzip -qo tmp/pharo64.zip
cp pharo64/* $TEMP_MULTI_SERCLI/
$TEMP_MULTI_SERCLI/pharo --nodisplay $TEMP_MULTI_SERCLI/Pharo7*64*.image eval "
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
"

# Adding VMs
# ArmVM:
TEMP_ARM_VM=temp-arm-vm
unzip -qo tmp/latst.zip -d $TEMP_ARM_VM
mv $TEMP_ARM_VM/lib/pharo/5* $TEMP_ARM_VM/lib/pharo/$LIB_FOLDER
cp $TEMP_ARM_VM/lib/pharo/$LIB_FOLDER/pharo $TEMP_ARM_VM/lib/pharo/$LIB_FOLDER/pharo-arm
cp $TEMP_ARM_VM/ $TEMP_MULTI_SERCLI/
cp $TEMP_ARM_VM/ $TEMP_RASP_SERCLI/
cp $TEMP_ARM_VM/ $TEMP_RASP_SER/

# Windows32 VM
unzip -qo tmp/pharo-win-stable.zip
cp pharo-win-stable/* $TEMP_MULTI_SERCLI/

# Mac32 VM
unzip -qo tmp/pharo-mac-stable.zip -d $TEMP_MULTI_SERCLI

rm -rf tmp $TEMP_ARM_VM pharo64-linux-stable pharo-win-stable pharo64