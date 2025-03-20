#!/bin/bash

echo `date`

cd /ConnectDashboard

wget http://connectdashboard.external.rae-corp.com/dashboard_v2.zip.sha256 -O dashboard.zip.sha256.new



if cmp -s dashboard.zip.sha256 dashboard.zip.sha256.new; then
        echo "No Update"
        rm dashboard.zip.sha256.new
else
        echo "Update Connect Dashboard"
        wget http://connectdashboard.external.rae-corp.com/dashboard_v2.zip -O dashboard.zip
        systemctl stop RAEConnectDashboard
        unzip -o dashboard.zip
#       chmod +x RAEConnectServer
        chown -R rae:rae /ConnectDashboard/*
        systemctl start RAEConnectDashboard
        mv dashboard.zip.sha256.new dashboard.zip.sha256

fi

echo