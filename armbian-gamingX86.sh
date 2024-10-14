#!/bin/bash

function menu {
echo "Please choose what you want to install! "
echo "1. Install steam. "
echo "2. Build and install PPSSPP. "
echo "3. Install Malior-droid Android emulator. "
echo "4. Build retropie. "
echo "5. Build Xonotic. "
echo "6. Exit "

read choicevar
if [ $choicevar -eq 1 ]
	then
	installSteamx86
elif [ $choicevar -eq 2 ]
	then 
	installPPSSPP
elif [ $choicevar -eq 3 ]
	then 
	installMaliorDroid
elif [ $choicevar -eq 4 ]
	then 
	installRetropie
elif [ $choicevar -eq 5 ]
	then 
	buildXonotic
elif [ $choicevar -eq 6 ]
	then
	echo "Greetings, NicoD "
	exit
else 
	echo "Invalid choice. "
fi
}

function installSteamx86 { 
  sudo dpkg --add-architecture i386
  sudo apt update
  sudo apt install wget gdebi-core libgl1-mesa-glx:i386
  wget -O ~/steam.deb http://media.steampowered.com/client/installer/steam.deb
  sudo dpkg -i ~/steam.deb
  echo "Run steam in terminal to open."
}

function installPPSSPP {
	cd ~
	git clone --recurse-submodules https://github.com/hrydgard/ppsspp.git
	cd ppsspp
	git pull --rebase https://github.com/hrydgard/ppsspp.git
	git submodule update --init --recursive
	sudo apt -y install build-essential cmake libgl1-mesa-dev libsdl2-dev libvulkan-dev
	/bin/bash ./b.sh
	cd build
	make
	sudo make install
}

function installMaliorDroid {
	echo "Installing Malior-Droid! Thanks to monkaBlyat and ChisBread! "
	sudo apt -y install docker docker.io adb
	sudo mkdir /dev/binderfs
	sudo mount -t binder binder /dev/binderfs
	wget -O - https://github.com/ChisBread/malior/raw/main/install.sh > /tmp/malior-install.sh && bash /tmp/malior-install.sh  && rm /tmp/malior-install.sh 
	malior update
	malior install malior-droid
	malior-droid update

	#install scrpy version 2.0 that is needed for audio forwarding from the android docker container

	# for Debian/Ubuntu
	sudo apt -y install ffmpeg libsdl2-2.0-0 adb wget gcc git pkg-config meson ninja-build libsdl2-dev libavcodec-dev libavdevice-dev libavformat-dev libavutil-dev libswresample-dev libusb-1.0-0 libusb-1.0-0-dev

	git clone https://github.com/Genymobile/scrcpy
	cd scrcpy
	./install_release.sh
	echo "To use : "
	echo "adb connect localhost:5555 "
	echo "scrcpy -s localhost:5555 "
}

function installRetropie {
	sudo apt update
 	sudo apt -y dist-upgrade
  	sudo apt install git
   	cd ~
    	git clone --depth=1 https://github.com/RetroPie/RetroPie-Setup.git
     	cd RetroPie-Setup
	sudo ./retropie_setup.sh
}

function buildXonotic {
	cd ~
	sudo apt-get -y install autoconf automake build-essential curl git libtool libgmp-dev libjpeg-turbo8-dev libsdl2-dev libxpm-dev xserver-xorg-dev zlib1g-dev unzip zip
	git clone https://gitlab.com/xonotic/xonotic.git  # download main repo
	cd xonotic
	./all update -l best
	./all compile -r
	echo "Xonotic is compiled. Start with ./all run. "
}

menu
