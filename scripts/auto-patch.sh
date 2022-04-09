#!/bin/bash

mkdir -p /etc/systemd/system/apt-daily.timer.d
cat > /etc/systemd/system/apt-daily.timer.d/override.conf << EOF
[Timer]
OnCalendar=
OnCalendar=04:00
RandomizedDelaySec=15m
EOF
mkdir -p /etc/systemd/system/apt-daily-upgrade.timer.d
cat > /etc/systemd/system/apt-daily-upgrade.timer.d/override.conf << EOF
[Timer]
OnCalendar=
OnCalendar=04:30
RandomizedDelaySec=0
EOF
sed -ri "s/(APT::Periodic::Update-Package-Lists[	 ]+\")[^\"]*/\1always/" /etc/apt/apt.conf.d/20auto-upgrades
sed -ri "s/(APT::Periodic::Unattended-Upgrade[	 ]+\")[^\"]*/\1always/" /etc/apt/apt.conf.d/20auto-upgrades
sed -ri "s/(\/\/[	 ]*)?(Unattended-Upgrade::Automatic-Reboot[	 ]+\")[^\"]*/\2true/" /etc/apt/apt.conf.d/50unattended-upgrades
systemctl daemon-reload && echo Auto patching enabled!
