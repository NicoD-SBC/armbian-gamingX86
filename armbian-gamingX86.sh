#!/bin/bash

function menu {
echo "Please choose what you want to install! "
echo "1. Install steam. "
echo "2. Build and install PPSSPP. "
echo "3. Build retropie. "
echo "4. Build Xonotic. "
echo "5. Exit "

read choicevar
if [ $choicevar -eq 1 ]
	then
	installSteamx86
elif [ $choicevar -eq 2 ]
	then 
	installPPSSPP

elif [ $choicevar -eq 3 ]
	then 
	installRetropie
elif [ $choicevar -eq 4 ]
	then 
	buildXonotic
elif [ $choicevar -eq 5 ]
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
  sudo apt install wget gdebi-core libgl1-mesa-glx:i386 libc6-i386 libgl1-mesa-dri:i386 libgl1:i386 mesa-vulkan-drivers
  wget -O ~/steam.deb http://media.steampowered.com/client/installer/steam.deb
  sudo dpkg -i ~/steam.deb
  echo "Run steam in terminal to open."
}

function installPPSSPP {
	sudo apt-get -y install libglfw3-dev libgl1-mesa-dev libglu1-mesa-dev build-essential cmake libgl1-mesa-dev libsdl2-dev libvulkan-dev
	cd ~
	git clone --recurse-submodules https://github.com/hrydgard/ppsspp.git
	cd ppsspp
	git pull --rebase https://github.com/hrydgard/ppsspp.git
	git submodule update --init --recursive
	/bin/bash ./b.sh
	cd build
	make
	sudo make install
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
