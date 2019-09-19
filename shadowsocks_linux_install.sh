#!/bin/bash

yum update
yum -y install python-setuptools && easy_install pip
pip install shadowsocks
yum -y install vim

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



