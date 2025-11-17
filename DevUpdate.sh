#!/bin/bash

echo `date`

cd /RAEConnect

wget http://connectdev.external.rae-corp.com/connect.zip.sha256 -O RAEConnectServer.zip.sha256.new


if cmp -s RAEConnectServer.zip.sha256 RAEConnectServer.zip.sha256.new; then
        echo "No Update"
        rm RAEConnectServer.zip.sha256.new
else
        echo "Updating Connect Server"
        wget http://connectdev.external.rae-corp.com/connect.zip -O RAEConnectServer.zip.new
        systemctl stop RAEConnect
        mv RAEConnectServer.zip.new RAEConnectServer.zip
        unzip -o RAEConnectServer.zip
#       chmod +x RAEConnectServer
        chown -R rae:rae /RAEConnect/*
        systemctl start RAEConnect
        mv RAEConnectServer.zip.sha256.new RAEConnectServer.zip.sha256
fi
echo
