#!/bin/bash
trap 'echo "$ $BASH_COMMAND"' DEBUG
set -e

curl -fs https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /usr/share/keyrings/githubcli-archive-keyring.gpg > /dev/null
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

sudo apt update
function try_install {
	if ! command -v $2 >/dev/null 2>&1; then
		sudo apt install $1 -y || { echo "Failed to install essential packages."; exit 1; }
	fi
}

try_install ssh
try_install git
try_install gh

if [ $? -ne 0 ]; then
	echo "Failed to install essential packages."
	exit 1
fi

if command -v gh >/dev/null 2>&1; then
	ssh-keygen -o
	if [ $? -eq 0 ]; then # keygen successfully
		echo "GitHub CLI installed"
		eval "$(ssh-agent -s)"
		ssh-add $HOME/.ssh/id_rsa

		echo "Choose to authenticate git using a browser, you can then authenticate by pasting your public key at https://github.com/settings/ssh/new"
		echo "YOUR PUBLIC KEY:"
		cat $HOME/.ssh/id_rsa.pub

		echo ""
		echo "After that, please authenticate with GitHub via CLI."
		echo "Choose to authenticate GitHub CLI using a browser, you can then authenticate using a handheld by visiting https://github.com/login/device"
		gh auth login
	fi
fi

trap - DEBUG
echo "Done!"
