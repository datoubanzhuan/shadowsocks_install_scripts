#!/bin/bash

set -e

source ./get_dist_name.sh
package_tool=$(get_dist_name)

if [[ "yum" = "$package_tool" ]]; then
    yum update
    yum -y install python-setuptools && easy_install pip
    yum -y install vim
elif [[ "apt" = "$package_tool" ]]; then
    apt-get update
    apt-get install -y --no-install-recommends build-essential python-dev python-setuptools python-pip
    apt-get install -y --no-install-recommends vim
fi
    
pip install shadowsocks

if [[ -n "$1" ]]; then
    password=$1
else
    password="password"
fi

if [[ -f "/etc/shadowsocks.json" ]]; then
    echo "Have existed shadowsocks.json"
    rm /etc/shadowsocks.json
fi
echo -e '{
	"server":"0.0.0.0",
	"server_port":"8389",
	"password":"'"$password"'",
	"timeout":300,
	"method":"aes-256-cfb",
	"fast_open":true,
	"workers": 1
    }' > /etc/shadowsocks.json

# start on boot
echo "ssserver -c /etc/shadowsocks.json -d start" >> /etc/rc.local
