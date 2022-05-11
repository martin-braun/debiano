# debiano

A useful setup script collection for Proxmox VE 7 that can be used remotely.

## Install scripts

If you don't use the subscription repository, please run this first: 

```
mv /etc/apt/sources.list.d/pve-enterprise.list /etc/apt/sources.list.d/pve-enterprise.list.disabled
echo "deb http://download.proxmox.com/debian/pve bullseye pve-no-subscription" > /etc/apt/sources.list.d/pve-no-subscription.list && apt update
```

On a fresh start it is recommend to run: 

```
dpkg-reconfigure tzdata && timedatectl set-timezone UTC
apt update && apt full-upgrade -y && apt autoremove -y
```

### Auto-Patch

Install upgrades at 3 AM UTC and reboot if necessary.

```
curl https://raw.githubusercontent.com/martin-braun/debiano/proxmox-ve7/scripts/auto-patch.sh | bash -s -- 
```

### Install Certbot

```sh
curl https://raw.githubusercontent.com/martin-braun/debiano/proxmox-ve7/scripts/install-certbot.sh | bash -s -- 
```

### Remove Nag

To remove the nag alert that tells to subscribe:

```sh
curl https://raw.githubusercontent.com/martin-braun/debiano/proxmox-ve7/scripts/remove-nag.sh | bash -s -- 
```
