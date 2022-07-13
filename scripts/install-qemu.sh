#!/bin/bash
trap 'echo "$ $BASH_COMMAND"' DEBUG

function try_install {
	if ! command -v $2 >/dev/null 2>&1; then
		sudo apt install $1 -y || { echo "Failed to install essential packages."; exit 1; }
	fi
}

try_install qemu qemu
# t.b.d.

trap - DEBUG
echo "Done!"
