# debiano

A useful setup script collection for Debian for Desktop environments that can be used remotely. On your installation disable root, enable http updates as well as non-free packages and skip auto updates and system utilities.

## Install scripts

Start off by installing the essentials: 

```sh
su -
usermod -aG sudo YOUR_USERNAME
reboot
```

After reboot:

```sh
sudo apt update && sudo apt full-upgrade -y && sudo apt autoclean && sudo apt autoremove -y
sudo apt install curl ca-certificates -y
```

Also recommend:

```sh
sudo apt install vim aptitude apt-rdepends xclip python3-pip -y
pip3 install opencv-python
```

### Install git / GitHub CLI

Install git and GitHub CLI as well as create and upload key

```sh
curl https://raw.githubusercontent.com/martin-braun/debiano/desk/scripts/install-git-gh.sh | bash -s --
```

### Install debiano with utils (requires git)

Install all these install scripts and additional utils to your system. Utils consist of useful scripts, functions and aliases that will be made available in $PATH.

```sh
curl https://raw.githubusercontent.com/martin-braun/debiano/desk/scripts/install-debiano.sh | bash -s --
```

Upgrade with: 

```sh
git -C ~/git/gh/martin-braun/debiano/ pull
```

### Install rolling repositories

Subscribe to the testing repository and get hot fixes from the unstable repository. Also subscribe several useful repositories

```sh
curl https://raw.githubusercontent.com/martin-braun/debiano/desk/scripts/install-rolling-repos.sh | bash -s --
```

or locally: 

```sh
sudo ~/git/gh/martin-braun/debiano/scripts/install-rolling-repos.sh
```

Finalize by install packages: 

```sh
sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y
```

or locally: 

```sh
apt-upd
```

### Install DNS stub resolver

Encrypt DNS queries:

```sh
curl https://raw.githubusercontent.com/martin-braun/debiano/desk/scripts/install-dns-stub-resolver.sh | bash -s --
```

or locally: 

```sh
~/git/gh/martin-braun/debiano/scripts/install-dns-stub-resolver.sh
```

### Install suckless suite

Compile and install suckless suite (dwm / st):

```sh
sudo tasksel --new-install # install only system utilities (if not done yet) and re-log
curl https://raw.githubusercontent.com/martin-braun/debiano/desk/scripts/install-suckless-suite.sh | bash -s --
```

or locally: 

```sh
sudo tasksel --new-install # install only system utilities (if not done yet) and re-log
~/git/gh/martin-braun/debiano/scripts/install-suckless-suite.sh
```

### Install Firefox and privacy user.js


```sh
curl https://raw.githubusercontent.com/martin-braun/debiano/desk/scripts/install-firefox.sh | bash -s --
```

or locally: 

```sh
~/git/gh/martin-braun/debiano/scripts/install-firefox.sh
```
