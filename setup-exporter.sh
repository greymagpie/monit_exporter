#!/bin/bash
go mod init monit_exporter
https_proxy=http://10.50.1.4:8081 go get github.com/prometheus/client_golang/prometheus/
https_proxy=http://10.50.1.4:8081 go get github.com/prometheus/log
https_proxy=http://10.50.1.4:8081 go get github.com/prometheus/client_golang/prometheus/promhttp
https_proxy=http://10.50.1.4:8081 go get github.com/spf13/viper
https_proxy=http://10.50.1.4:8081 go get golang.org/x/net/html/charset
go build