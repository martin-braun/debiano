#!/bin/bash
trap 'echo "$ $BASH_COMMAND"' DEBUG
set -e

installroot=$HOME/git/gh/martin-braun
if [ $1 ]; then
	installroot=$1
fi
mkdir -p $installroot

git clone -b desk git@github.com:martin-braun/debiano.git $installroot/debiano
echo "source $installroot/debiano/utils/.bashrc" >> $HOME/.bashrc
source $HOME/.bashrc

trap - DEBUG
echo "Done!"
