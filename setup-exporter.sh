#TODO #12 
#Workaround
cp config.toml /usr/local/go/bin/

#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo "Set http/s_proxy? (e.g. http://ip:port)"
read -r proxy
if [[ $proxy == "http://"* ]]; then
    export http_proxy=$proxy
    export https_proxy=$proxy
    goProxy="https_proxy=$proxy"
fi

echo "Install golang 1.21.6? (Y/n)"
read -r golang

if [[ "$golang" == "y" ]]; then
    bash setup-go.sh
fi

go mod init monit_exporter
go mod tidy
echo "$goProxy go get github.com/prometheus/client_golang/prometheus/" | bash
echo "$goProxy go get github.com/prometheus/log" | bash
echo "$goProxy go get github.com/prometheus/client_golang/prometheus/promhttp" | bash
echo "$goProxy go get github.com/spf13/viper" | bash
echo "$goProxy go get golang.org/x/net/html/charset" | bash
go build
cp monit_exporter /usr/local/go/bin/

echo "Install systemd file & service check? (Y/n)"
read -r systemd
if [[  "$systemd" == "y" ]]; then
  touch /var/log/monit_exporter.log
  cp monit_exporter.service /etc/systemd/system/
  systemctl enable monit_exporter --now
  systemctl start monit_exporter
  cp monit_exporter_checker.conf /etc/monit/conf.d/monit_exporter
  systemctl restart monit
fi

# clean up
export http_proxy=""
export https_proxy=""