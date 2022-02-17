#!/bin/bash

# apt install unattended-upgrades apt-listchanges -y # already installed

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

perl -i -pe "s/(APT::Periodic::Update-Package-Lists\\s+\")[^\"]/\$1always/gis" /etc/apt/apt.conf.d/20auto-upgrades
perl -i -pe "s/(APT::Periodic::Unattended-Upgrade\\s+\")[^\"]/\$1always/gis" /etc/apt/apt.conf.d/20auto-upgrades

perl -i -pe "s/(\/\/\\s+\"origin=Debian,codename=\${distro_codename}-updates)/        \$1/gis" /etc/apt/apt.conf.d/50unattended-upgrades
cat >> /etc/apt/apt.conf.d/50unattended-upgrades << EOF

Unattended-Upgrade::Automatic-Reboot "true";
EOF

systemctl daemon-reload