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
mkdir -p tmp/$TEMP_RASP_SER && cd tmp/$TEMP_RASP_SER
wget -O - get.pharo.org/70 | bash
mv Pharo.image PharoThings32.image
mv Pharo.changes PharoThings32.changes
cd ../..
./tmp/pharo32/pharo tmp/$TEMP_RASP_SER/PharoThings32.image eval "
$1 Iceberg enableMetacelloIntegration: true.
Metacello new
  baseline: 'PharoThings';
  repository: 'github://pharo-iot/PharoThings/src';
  load: #(RemoteDevServer Raspberry). $1
Smalltalk saveSession. 
"   > /dev/null 2>&1
mkdir $TEMP_RASP_SER
cp tmp/$TEMP_RASP_SER/PharoThings32.image $TEMP_RASP_SER
cp tmp/$TEMP_RASP_SER/PharoThings32.changes $TEMP_RASP_SER
cp tmp/$TEMP_RASP_SER/Pharo*.sources $TEMP_RASP_SER
cp tmp/pharo $TEMP_RASP_SER
cp tmp/pharo-ui $TEMP_RASP_SER
cp tmp/pharo-server $TEMP_RASP_SER

# 1.3 Pharo 7 IoT Raspberry Server Client
cp -r tmp/$TEMP_RASP_SER/ tmp/$TEMP_RASP_SERCLI/
./tmp/pharo32/pharo tmp/$TEMP_RASP_SERCLI/PharoThings32.image eval "
Iceberg enableMetacelloIntegration: true.
$1 Metacello new
  baseline: 'PharoThings';
  repository: 'github://pharo-iot/PharoThings/src';
  load: 'RemoteDev'. $1
Smalltalk saveSession. 
"  > /dev/null 2>&1
mkdir $TEMP_RASP_SERCLI
cp tmp/$TEMP_RASP_SERCLI/PharoThings32.image $TEMP_RASP_SERCLI
cp tmp/$TEMP_RASP_SERCLI/PharoThings32.changes $TEMP_RASP_SERCLI
cp tmp/$TEMP_RASP_SERCLI/Pharo*.sources $TEMP_RASP_SERCLI
cp tmp/pharo $TEMP_RASP_SERCLI
cp tmp/pharo-ui $TEMP_RASP_SERCLI
cp tmp/pharo-server $TEMP_RASP_SERCLI

# 1.4 Pharo 7 IoT Multiplataform Server Client
cp -r tmp/$TEMP_RASP_SERCLI/ tmp/$TEMP_MULTI_SERCLI/
cd tmp/$TEMP_MULTI_SERCLI/
wget -O - get.pharo.org/64/70 | bash
mv Pharo.image PharoThings64.image
mv Pharo.changes PharoThings64.changes
cd ../..
./tmp/pharo64/pharo tmp/$TEMP_MULTI_SERCLI/PharoThings64.image eval "
Iceberg enableMetacelloIntegration: true.
$1 Metacello new
  baseline: 'PharoThings';
  repository: 'github://pharo-iot/PharoThings/src';
  load: 'RemoteDev'.
Metacello new
  baseline: 'PharoThings';
  repository: 'github://pharo-iot/PharoThings/src';
  load: #(RemoteDevServer Raspberry). $1
Smalltalk saveSession. 
"  > /dev/null 2>&1
mkdir $TEMP_MULTI_SERCLI
cp tmp/$TEMP_MULTI_SERCLI/PharoThings32.image $TEMP_MULTI_SERCLI
cp tmp/$TEMP_MULTI_SERCLI/PharoThings32.changes $TEMP_MULTI_SERCLI
cp tmp/$TEMP_MULTI_SERCLI/PharoThings64.image $TEMP_MULTI_SERCLI
cp tmp/$TEMP_MULTI_SERCLI/PharoThings64.changes $TEMP_MULTI_SERCLI
cp tmp/$TEMP_MULTI_SERCLI/Pharo*.sources $TEMP_MULTI_SERCLI
cp tmp/pharo $TEMP_MULTI_SERCLI
cp tmp/pharo-ui $TEMP_MULTI_SERCLI
cp tmp/pharo-server $TEMP_MULTI_SERCLI
cp tmp/pharo.bat $TEMP_MULTI_SERCLI

# Step 2 - Packaging VMs
# 2.1 ArmVM for all packages
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

# 2.4 Linux32 for multiplatform only
mkdir -p $TEMP_MULTI_SERCLI/vm/linux32
unzip -qo tmp/pharo-linux-stable.zip -d $TEMP_MULTI_SERCLI/vm/linux32

# 2.5 Linux64 for multiplatform only
mkdir -p $TEMP_MULTI_SERCLI/vm/linux64
unzip -qo tmp/pharo64-linux-stable.zip -d $TEMP_MULTI_SERCLI/vm/linux64

# Clean up temp folders
#rm -rf tmp
