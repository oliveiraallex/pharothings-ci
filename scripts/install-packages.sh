#!/bin/bash 

set -ex

TEMP_RASP_SER=pharo7-iot-rasp-ser
TEMP_RASP_SERCLI=pharo7-iot-rasp-ser-cli
TEMP_MULTI_SERCLI=pharo7-iot-multi-ser-cli

# Step 1 - Prepare images

# 1.1 Download the PharoVM for the current platform
# We use this VM to prepare the images we are going to package
mkdir -p tmp/pharo32 && cd tmp/pharo32
wget -O - get.pharo.org/vm70 | bash
cd ../..

mkdir -p tmp/pharo64 && cd tmp/pharo64
wget -O - get.pharo.org/64/vm70 | bash
cd ../..


# 1.2 Pharo 7 IoT Raspberry Server
mkdir $TEMP_RASP_SER
cd $TEMP_RASP_SER
wget -O - get.pharo.org/70 | bash
mv Pharo.image PharoThings32.image
mv Pharo.changes PharoThings32.changes
cd ..

./tmp/pharo32/pharo $TEMP_RASP_SER/PharoThings32.image eval "
Iceberg enableMetacelloIntegration: true.
\"Metacello new
  baseline: 'PharoThings';
  repository: 'github://pharo-iot/PharoThings/src';
  load: #(RemoteDevServer Raspberry).\"
Smalltalk saveSession. 
"   > /dev/null 2>&1

# 1.3 Pharo 7 IoT Raspberry Server Client
cp -r $TEMP_RASP_SER/ $TEMP_RASP_SERCLI
./tmp/pharo32/pharo $TEMP_RASP_SERCLI/PharoThings32.image eval "
Iceberg enableMetacelloIntegration: true.
\"Metacello new
  baseline: 'PharoThings';
  repository: 'github://pharo-iot/PharoThings/src';
  load: 'RemoteDev'.\"
Smalltalk saveSession. 
"  > /dev/null 2>&1

# 1.4 Pharo 7 IoT Multiplataform Server Client
cp -r $TEMP_RASP_SERCLI/ $TEMP_MULTI_SERCLI
cd $TEMP_MULTI_SERCLI
wget -O - get.pharo.org/64/70 | bash
mv Pharo.image PharoThings64.image
mv Pharo.changes PharoThings64.changes
cd ..

./tmp/pharo64/pharo $TEMP_MULTI_SERCLI/PharoThings64.image eval "
Iceberg enableMetacelloIntegration: true.
\"Metacello new
  baseline: 'PharoThings';
  repository: 'github://pharo-iot/PharoThings/src';
  load: 'RemoteDev'.
Metacello new
  baseline: 'PharoThings';
  repository: 'github://pharo-iot/PharoThings/src';
  load: #(RemoteDevServer Raspberry).\"
Smalltalk saveSession. 
"  > /dev/null 2>&1

# 1.5 Clean Directories

rm -rf $TEMP_RASP_SER/pharo-local
rm -rf $TEMP_RASP_SERCLI/pharo-local
rm -rf $TEMP_MULTI_SERCLI/pharo-local

# Step 2 - Packaging VMs

#LIB_FOLDER=$(ls $TEMP_MULTI_SERCLI/lib/pharo/)

#mv $TEMP_MULTI_SERCLI/lib/pharo/$LIB_FOLDER/pharo $TEMP_MULTI_SERCLI/lib/pharo/$LIB_FOLDER/pharo-32
#unzip -qo tmp/pharo64-linux-stable.zip -d $TEMP_MULTI_SERCLI
#cp $TEMP_MULTI_SERCLI/lib/pharo/$LIB_FOLDER/pharo $TEMP_MULTI_SERCLI/lib/pharo/$LIB_FOLDER/pharo-64


# 2.1 ArmVM for all packages
TEMP_ARM_VM=tmp/temp-arm-vm
mkdir -p $TEMP_RASP_SER/vm/arm
unzip -qo tmp/latest.zip -d $TEMP_RASP_SER/vm/arm

mkdir -p $TEMP_RASP_SERCLI/vm/arm
unzip -qo tmp/latest.zip -d $TEMP_RASP_SERCLI/vm/arm

mkdir -p $TEMP_MULTI_SERCLI/vm/arm
unzip -qo tmp/latest.zip -d $TEMP_MULTI_SERCLI/vm/arm

# 2.2 Win32 for multiplatform only
mkdir -p $TEMP_MULTI_SERCLI/vm/win32
unzip -qo tmp/pharo-win-stable.zip -d $TEMP_MULTI_SERCLI/vm/win32

# 2.3 OSX32 for multiplatform only
mkdir -p $TEMP_MULTI_SERCLI/vm/osx32
unzip -qo tmp/pharo-mac-stable.zip -d $TEMP_MULTI_SERCLI/vm/osx32

# 2.4 Linux64 for multiplatform only
mkdir -p $TEMP_MULTI_SERCLI/vm/linux64
unzip -qo tmp/pharo64-linux-stable.zip -d $TEMP_MULTI_SERCLI/vm/linux64

# Clean up temp folders
rm -rf tmp
