#!/bin/bash

apt install nginx -y
nginx -v
rm -rf /etc/nginx/sites-enabled/default
echo "Upload nginx conf files to /etc/nginx/sites-enabled and run:"
echo ""
echo "    nginx -t && systemctl reload nginx"
