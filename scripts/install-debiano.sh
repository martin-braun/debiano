#!/bin/bash

installroot=$HOME/git/gh/martin-braun
if [ $1 ]; then
	installroot=$1
fi
mkdir -p $installroot
git clone -b desktop git@github.com:martin-braun/debiano.git $installroot/debiano
echo "source $installroot/debiano/util/.bashrc" >> $HOME/.bashrc
source $HOME/.bashrc
echo "Done!"
