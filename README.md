# debiano

A useful script collection for Debian 10 that can be used remotely.

## Install scripts

On a fresh start it is recommend to run: 

```
apt update && apt upgrade -y
```

### Install nginx

```sh
curl https://raw.githubusercontent.com/martin-braun/debiano/v10/scripts/install-nginx.sh | bash -s -- 
```

### Install PHP 7.4 (FPM) for nginx

```sh
curl https://raw.githubusercontent.com/martin-braun/debiano/v10/scripts/install-nginx-phpfpm-7_4.sh | bash -s -- 
```

### Install Certbot (for nginx)

```sh
curl https://raw.githubusercontent.com/martin-braun/debiano/v10/scripts/install-certbot.sh | bash -s -- 
```
