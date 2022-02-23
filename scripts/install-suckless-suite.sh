#!/bin/bash

sudo apt update

function try_install {
	if ! command -v $2 >/dev/null 2>&1; then
		sudo apt install $1 -y || { echo "Failed to install essential packages."; exit 1; }
	fi
}

try_install git git
try_install gcc gcc
try_install make make
try_install xorg startx
sudo apt install build-essential libxinerama-dev libx11-dev libxft-dev -y

pwd=$(pwd)
installroot=$HOME/git/gh/martin-braun
mkdir -p $installroot

function download_suckless_fork {
	if [ -d $installroot/$1 ]; then
		git -C $installroot/$1 pull
	else
		git clone git@github.com:martin-braun/$1.git $installroot/$1
	fi
	if [ $? -ne 0 ]; then
		echo "Failed to install essential packages."
		exit 1
	fi
}

function build_suckless_fork {
	cd $installroot/dwm
	make clean
	make
	sudo make install
	cd $pwd
	if [ $? -ne 0 ]; then
		echo "Failed to install dwm."
		exit 1
	fi
}

download_suckless_fork dwm
download_suckless_fork st
download_suckless_fork dmenu


build_suckless_fork dwm
echo "exec dwm" > $HOME/.xinitrc

build_suckless_fork st
build_suckless_fork dmenu
