#!/bin/bash
trap 'echo "$ $BASH_COMMAND"' DEBUG
set -e

stables="stretch|buster|bullseye|bookworm"

sudo apt update
function try_install {
	if ! command -v $2 >/dev/null 2>&1; then
		sudo apt install $1 -y || { echo "Failed to install essential packages."; exit 1; }
	fi
}

try_install debsecan

# refresh necessary public keys first
curl -sf https://repo.sparkylinux.org/sparky.gpg.key | sudo tee /etc/apt/trusted.gpg.d/sparky.gpg.key >/dev/null

# switch to testing repository without backports
sudo perl -i -pe "s/^(deb(-src)?\\s+[^\\s]+\\s+)$stables/\$1testing/gmis" /etc/apt/sources.list
sudo perl -i -pe "s/^deb(-src)?\\s+[^\\s]+\\s+$stables-backport.+$//gmis" /etc/apt/sources.list

# add debian unstable for hot fixes
sudo cat << EOF
deb http://deb.debian.org/debian/ unstable main non-free contrib
deb-src http://deb.debian.org/debian/ unstable main non-free contrib
EOF > /etc/apt/sources.list.d/sid.list

# add multimedia testing repository
sudo cat << EOF
deb http://deb-multimedia.org/ testing main non-free
deb-src http://deb-multimedia.org/ testing main non-free
EOF > /etc/apt/sources.list.d/multimedia.list

# add multimedia unstable repository for hot fixes
sudo cat << EOF
deb http://deb-multimedia.org/ unstable main
deb-src http://deb-multimedia.org/ unstable main
EOF > /etc/apt/sources.list.d/multimedia-sid.list

# add sparky testing repository
sudo cat << EOF
deb https://repo.sparkylinux.org/ testing main
deb-src https://repo.sparkylinux.org/ testing main
EOF > /etc/apt/sources.list.d/sparky.list

# add sparky unstable repository for hot fixes
sudo cat << EOF
deb https://repo.sparkylinux.org/ unstable main
deb-src https://repo.sparkylinux.org/ unstable main
EOF > /etc/apt/sources.list.d/sparky-unstable.list

# add siduction unstable repository for hot fixes
sudo cat << EOF
deb https://packages.siduction.site/fixes unstable main non-free contrib
deb-src https://packages.siduction.site/fixes unstable main non-free contrib
EOF > /etc/apt/sources.list.d/siduction.list

# prefer to install packages from testing repositories by default
sudo cat << EOF
'APT::Default-Release "testing";'
EOF > /etc/apt/apt.conf.d/00default-release

# enable selective unstable upgrades for hot fixes
sudo cat << EOF
APT::Update::Pre-Invoke { "/usr/sbin/debsecan-apt-priority"; };
EOF > /etc/apt/apt.conf.d/99debsecan
curl https://raw.githubusercontent.com/martin-braun/debiano/desktop/assets/debsecan-apt-priority > /usr/sbin/debsecan-apt-priority

# define unstable exceptions
# sudo cat << EOF
# Package: chromium chromium-sandbox chromium-common
# Pin: release a=unstable
# Pin-Priority: 990

# Package: firefox libnss3 libnss3:i386 libnss3-dev
# Pin: release a=unstable
# Pin-Priority: 990
# EOF > /etc/apt/preferences.d/unstable-packages

trap - DEBUG
echo "Done!"
