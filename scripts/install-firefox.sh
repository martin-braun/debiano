#!/bin/bash
trap 'echo "$ $BASH_COMMAND"' DEBUG

function try_install {
	if ! command -v $2 >/dev/null 2>&1; then
		sudo apt install $1 -y || { echo "Failed to install essential packages."; exit 1; }
	fi
}

try_install firefox-esr firefox

installdir=$HOME/git/gh/arkenfox/user.js

if [ -d $installdir ]; then
	git -C $installdir pull
else
	mkdir -p $installdir
	git clone git@github.com:arkenfox/user.js.git $installdir
	sudo chmod +x $installdir/updater.sh
fi

$installdir/updater.sh -l
$installdir/updater.sh -l

trap - DEBUG
echo "Done!"
