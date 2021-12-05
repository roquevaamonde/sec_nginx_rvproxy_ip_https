# PROTEGE PROXY INVERSO NGINX EN SU DIRECCION IP PUBLICA PARA HTTPS CON DOMINIO DDNS
Este script funciona en el siguiente supuesto:
- Proxy inverso nginx en contenedor docker y projecto en docker compose
- Dominio configurado a travs de ddns e ip publica dinamica
- Es necesario disponer del comando nslookup

## ARCHIVO DE CONFIGURACION:
Es necesario crear una plantilla de nuestro archivo de configuracion de nginx:
Acceder al directorio de nginx conf.d y copiar el archivo default.conf y ponerle un nombre tipo pl_default (no poner la extension .conf para no confindir al nginx)

`$ cp ./default.conf pl_default`

editar pl_default y añadir el siguiente server:

```
    server {
        listen 443 ssl default_server;
        deny all;
        server_name $IP_PUBLICA;
        ssl_certificate         /etc/nginx/conf.d/certificate.crt;
        ssl_certificate_key     /etc/nginx/conf.d/privateKey.key;
    }
```

## MODIFICAR VARIABLES EN secure_https_ip.sh:


```
#!/usr/bin/env bash

workdir=/nginx-reverse-proxy-with-certbot-master
confd=$workdir/conf.d
historico=$confd/ip_historica.ip
domain="dominio.ddns.net"
dns="8.8.8.8"
plantilla="pl_default"
```





