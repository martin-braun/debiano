# debiano

A useful script collection for Proxmox VE 6 that can be used remotely.

## Install scripts

If you don't use the subscription repository, please run this first: 

```
mv /etc/apt/sources.list.d/pve-enterprise.list /etc/apt/sources.list.d/pve-enterprise.list.disabled
echo "deb http://download.proxmox.com/debian/pve buster pve-no-subscription" > /etc/apt/sources.list.d/pve-no-subscription.list
sed -Ezi.bak "s/(Ext.Msg.show\(\{\s+title: gettext\('No valid sub)/void\(\{ \/\/\1/g" /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js && systemctl restart pveproxy.service
```

On a fresh start it is recommend to run: 

```
dpkg-reconfigure tzdata # to setup UTC
apt update && apt upgrade -y && apt autoremove
```

> `pveupgrade` will execute `apt-get dist-upgrade` which is `apt full-upgrade` and thus is not recommend, unless upgrading after LTS.

### Auto-Patch

Install upgrades at 3 AM UTC and reboot if necessary.

```
curl https://raw.githubusercontent.com/martin-braun/debiano/proxmox-6/scripts/auto-patch.sh | bash -s -- 
```

### Install Certbot

```sh
curl https://raw.githubusercontent.com/martin-braun/debiano/proxmox-6/scripts/install-certbot.sh | bash -s -- 
```
