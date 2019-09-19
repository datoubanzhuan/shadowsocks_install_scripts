#!/bin/bash

source ./get_dist_name.sh
package_tool=$(get_dist_name)

if [[ "yum" = "$package_tool" ]]; then
    yum update
    yum -y install python-setuptools && easy_install pip
    yum -y install vim
elif [[ "apt" = "$package_tool" ]]; then
    apt-get update
    apt-get install -y --no-install-recommends python-setuptools && easy_install pip
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
else
    echo -e '{
	"server":["[::]","0.0.0.0"],
	"server_port":"8389",
	"password":""'"$password"'"",
	"timeout":300,
	"method":"aes-256-cfb",
	"fast_open":true,
	"workers": 1
    }'
fi



