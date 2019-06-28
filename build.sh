#!/bin/sh

echo -e "\033[32m download new package (version $1) \033[0m"
wget -O yapi.tgz http://registry.npm.taobao.org/yapi-vendor/download/yapi-vendor-$1.tgz

echo -e "\033[32m build new image \033[0m"
docker build -t anoy/yapi .