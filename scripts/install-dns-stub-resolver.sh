#!/bin/bash
trap 'echo "$ $BASH_COMMAND"' DEBUG

stables="stretch|buster|bullseye|bookworm"

function try_install {
	if ! command -v $2 >/dev/null 2>&1; then
		sudo apt install $1 -y || { echo "Failed to install essential packages."; exit 1; }
	fi
}

try_install stubby

# refresh DNS entries
sudo sed -i 's/- address_data: .*//g'  /etc/stubby/stubby.yml
sudo sed -i 's/tls_auth_name: .*//g'  /etc/stubby/stubby.yml
sudo sed -i "s|round_robin_upstreams: [01])|round_robin_upstreams: 1\n\
  - address_data: 76.76.2.0\n\
    tls_auth_name: \"p0.freedns.controld.com\"\n\
  - address_data: 2606:1a40::0\n\
    tls_auth_name: \"p0.freedns.controld.com\"\n\
  - address_data: 76.76.10.0\n\
    tls_auth_name: \"p0.freedns.controld.com\"\n\
  - address_data: 2606:1a40:1::0\n\
    tls_auth_name: \"p0.freedns.controld.com\"|gim" /etc/stubby/stubby.yml

# route all traffic to stubby
sudo sed -i 's/nameserver [0-9]*\.[0-9]*\.[0-9]*\.[0-9]*/nameserver 127.0.0.1/' /etc/resolv.conf

# test if QNAME minimization is working
dig +short txt qnamemintest.internet.nl

trap - DEBUG
echo "Done, please visit https://www.cloudflare.com/ssl/encrypted-sni/ to test if your DNS is encrypted."
