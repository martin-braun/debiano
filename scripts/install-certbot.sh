#!/bin/bash

apt install certbot -y

certbot certonly --standalone

certpath=`ls -d -1 /etc/letsencrypt/live/* | tail -n 1`
\cp $certpath/fullchain.pem /etc/pve/local/pveproxy-ssl.pem
\cp $certpath/privkey.pem /etc/pve/local/pveproxy-ssl.key
systemctl restart pveproxy

echo "0 0 1 * * certbot renew -n && \cp $certpath/fullchain.pem /etc/pve/local/pveproxy-ssl.pem && \cp $certpath/privkey.pem /etc/pve/local/pveproxy-ssl.key && systemctl restart pveproxy" >> /etc/crontab
