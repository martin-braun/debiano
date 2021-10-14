#!/bin/bash

apt install certbot python3-certbot-nginx cron -y
crontab -l > /tmp/crontab
echo "If no crontab was found, creating new instead"
echo "0 0 1 * * certbot renew -n" > /tmp/crontab
crontab /tmp/crontab && rm /tmp/crontab
echo "For each domain on nginx please run:"
echo ""
echo "    certbot --nginx -d <DOMAIN> && certbot renew --dry-run"
echo ""
