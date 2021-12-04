#!/usr/bin/env bash

workdir=/nginx-reverse-proxy-with-certbot-master
confd=$workdir/conf.d
historico=$confd/ip_historica.ip
domain="rhosting.ddns.net"
dns="8.8.8.8"
ip_actual=$(nslookup $domain | grep Address |  grep -v $dns | awk '{ print $NF }')

if [ $ip_actual != $(cat $historico) ];
  then
    echo $ip_actual > $historico
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout $confd/privateKey.key -out $confd/certificate.crt -subj "/CN=$ip_actual"
    export IP_PUBLICA=$ip_actual
    envsubst '${IP_PUBLICA}' < $confd/ex_default > $confd/default.conf
    cd $workdir
    docker-compose restart
    exit 0
else
    exit 0
fi
