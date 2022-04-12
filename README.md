# debiano

A useful setup script collection for Debian 10 servers that can be used remotely.

## Install scripts

Start off by installing the essentials: 

```sh
apt update && apt full-upgrade -y && apt autoremove -y
apt install curl wget software-properties-common gnupg -y
```

Also recommend: 

```sh
locale-gen en_US.UTF-8 && dpkg-reconfigure locales # and set en_US.UTF-8
``` 

### Auto-Patch

Install upgrades at 4 AM UTC and reboot if necessary.

```
curl https://raw.githubusercontent.com/martin-braun/debiano/buster/scripts/auto-patch.sh | bash -s -- 
```

### Install nginx

```sh
curl https://raw.githubusercontent.com/martin-braun/debiano/buster/scripts/install-nginx.sh | bash -s -- 
```

### Install PHP 7.4 (FPM) for nginx

```sh
curl https://raw.githubusercontent.com/martin-braun/debiano/buster/scripts/install-nginx-phpfpm-7_4.sh | bash -s -- 
```

### Install Certbot (for nginx)

```sh
curl https://raw.githubusercontent.com/martin-braun/debiano/buster/scripts/install-certbot.sh | bash -s -- 
```
