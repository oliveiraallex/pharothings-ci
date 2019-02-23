# pharothings-ci

PharoThings CI is a seamless integration process created using Travis CI. This process generate a Pharo image with PharoThings already installed and ready to be runned in multiplatform (Raspberry, Linux, Windows, Mac) with 1 click files. 

You can see the files to download in **[Releases page](https://github.com/oliveiraallex/pharothings-ci/releases)**. All zip files for download are created automatically. The process is basically:

- Create a local Pharo7 32-bit environment
- Install PharoThings (server)
- Copy this image to a new folder (client-server) and install the PharoThings client
- Copy this image to a new folder (multi)
- Create a local Pharo7 64-bit environment
- Install the 64-bit image of the PharoThings client server.
- Copy the VMs (Arm, Linux, Windows, Mac) to the vm folders
- Create 1 click multiplatform files
- Create 3 zip files for download. You can see the description of each file below
- Deploy the files in **[Releases page](https://github.com/oliveiraallex/pharothings-ci/releases)** when is created a new Tag. 

## Download the zip file according to your scenario:
There are 3 zip files with the VM and PharoThings already installed. 
- **pharothings-server (Raspberry Pi)**
This file has Pharo7, ARM VM and PharoThings **server** loaded;
**[Zeroconf](http://pharo.allexoliveira.com.br/server)**:`wget -O - http://pharo.allexoliveira.com.br/server | bash`
**[Download](http://pharo.allexoliveira.com.br/pharothings-server.zip)**:`wget http://pharo.allexoliveira.com.br/pharothings-server.zip`

- **pharothings-client (Raspberry Pi)**
This file has Pharo7, ARM VM, PharoThings **server and client** loaded. This way you can to work in the Raspberry Pi directly connected in a screen and keyboard/mouse, using the developer PharoThings tools, like the Board Inspector;
**[Zeroconf](http://pharo.allexoliveira.com.br/client)**:`wget -O - http://pharo.allexoliveira.com.br/client | bash`
**[Download](http://pharo.allexoliveira.com.br/pharothings-client.zip)**:`wget http://pharo.allexoliveira.com.br/pharothings-client.zip`

- **pharothings-multi (Raspberry Pi, Linux, Windows, Mac)**
This file has Pharo7, all VMs 32bit, PharoThings **server and client** loaded. 
**[Zeroconf](http://pharo.allexoliveira.com.br/multi)**:`wget -O - http://pharo.allexoliveira.com.br/multi | bash`
**[Download](http://pharo.allexoliveira.com.br/pharothings-multi.zip)**:`wget http://pharo.allexoliveira.com.br/pharothings-multi.zip`

## Start files
There are 4 files of *1 click start*. All of them start with the Pharo image already selected. You can use them according to your necessities:
- **pharo** (Raspberry, Linux, Mac OSX)
Run Pharo in the command line. You can pass arguments, for example `./pharo --help` or `./pharo --version`
- **pharo-ui** (Raspberry, Linux, Mac OSX)
Open Pharo User Interface. Double click or run in command line `./pharo-ui`. 
- **pharo-server** (Raspberry, Linux, Mac OSX)
Start pharo in headless mode with TelePharo listening on port 40423 TCP, run the command `./pharo-server` or double click in it. You can send the process to the background to release your terminal using &, for example `./pharo-server &`. 
- **pharo.bat** (Windows)
Open Pharo User Interface on Microsoft Windows.

## Connecting
1. Start the **pharo-server** on Raspberry Pi. 
2. Run the PharoThings client: **pharo-ui** (Mac, Linux) or **pharo.bat** (Windows). Open the Playground, type and run this line (cmd + D):
```
remotePharo := TlpRemoteIDE connectTo: (TCPAddress ip: #[192 168 1 200] port: 40423).
``` 
3. If you don't receive any error, this means that you are connected. Now you can inspect the physical board of your Raspberry Pi:
```
remoteBoard := remotePharo evaluate: [ RpiBoard3B current].
remoteBoard inspect.
```
You can also call the *Remote Playground*, *Remote System Browser* and *Remote Process Browser*:
```
remotePharo openPlayground.
remotePharo openBrowser.
remotePharo openProcessBrowser.
``` 

## Playing with PharoThings Booklet
You can start playing with LEDs, sensors and learn how to build your **Mini-Weather Station** to shows the temperature and other parameters in an LCD display, and send the data to a cloud server. 
All this content and lessons are written in the **PharoThings Booklet**, you can access it here: [PharoThings Booklet](https://github.com/SquareBracketAssociates/Booklet-APharoThingTutorial/blob/master/_result/pdf/index.pdf) 
