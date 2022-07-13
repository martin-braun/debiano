#!/bin/bash
trap 'echo "$ $BASH_COMMAND"' DEBUG

curl -fs https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /usr/share/keyrings/githubcli-archive-keyring.gpg > /dev/null
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update && sudo apt install ssh git gh -y
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
		echo "Please authenticate with GitHub and upload your SSH key to GitHub ..."
		echo "Choose to authenticate using a browser, you can then authenticate using a handheld by visiting https://github.com/login/device"
		gh auth login
	fi
fi

trap - DEBUG
echo "Done!"
