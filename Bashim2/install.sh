#!/bin/bash

sudo apt install git

git clone https://github.com/cjdelisle/cjdns.git cjdns

cd cjdns
./do

LANG=C cat /dev/net/tun 2>&1 | awk '{ if ( $0 == "cat: /dev/net/tun: No such file or directory") { 
	sudo mkdir -p /dev/net &&
	sudo mknod /dev/net/tun c 10 200 &&
	sudo chmod 0666 /dev/net/tun
	} else { 
	print "Good" 
	}  
	}'

LANG=C cat /dev/net/tun 2>&1 | awk '{ if ( $0 == "cat: /dev/net/tun: Permission denied"){
	print "Вы скорее всего используете виртуальный сервер (VPS) на основе технологии виртуализации OpenVZ. Попросите своего провайдера услуг включить TUN/TAP устройство, это стандартный протокол, ваш провайдер должен быть в курсе."}
	}'

./cjdroute --genconf >> cjdroute.conf
chmod 600 cjdroute.conf

echo -e "НАЙДИТЕ ПИРА \nДля доступа в сеть вам потребуется человек который уже в сети."

echo 'В файле cjdroute.conf вы увидите:

        // Nodes to connect to.
        "connectTo":
        {
            // Add connection credentials here to join the network
            // Ask somebody who is already connected.
        }
После добавления данных пира он будет выглядеть как-то так:

        // Nodes to connect to.
        "connectTo":
        {
            "0.1.2.3:45678":
            {
                "login": "user-login",
                "password": "thisIsNotARealConnection",
                "publicKey": "thisIsJustForAnExampleDoNotUseThisInYourConfFile.k"
            }
        }'

echo "IP пира:"
read ip
k=$(echo $ip | sed s/[^.]//g | wc -c)
echo 'login:'
read logn
echo "password:"
read pswd
echo "publicKey:"
read pblk
t="\"$ip\":\n\t{\n\t\t"'login'": "$logn",\n\t\t"password": "$pswd",\n\t\t"publicKey": "$pblk"\n\t}\n"
if (( "$k" == 4 )); then
	s=$(grep -n IPv4 cjdroute.conf | awk -F: '{print $1}')
	g=($s)
	n=$g
	n=$(($n+2))
	else
	s=$(grep -n IPv6 cjdroute.conf | awk -F: '{print $1}')
	g=($s)
	n=$g
	n=$(($n+2))	
	n=$(($n+2))
fi

sed -i "${n}s/^/PATTERN/" cjdroute.conf
sed -i "${n}s#PATTERN#$t#" cjdroute.conf

echo "Введите ваш IPv4 адрес, который люди будут использовать для подключения к вам через интернет: your.external.ip.goes.here:12345"
read s
sed -i "s/your.external.ip.goes.here:40352/$s/" cjdroute.conf

echo "Остановка cjdns осуществляется командой: sudo killall cjdroute"
echo "Логи записываются в файл cjdroute.log" 
sudo ./cjdroute < cjdroute.conf > cjdroute.log
