#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
GRAY='\033[0;37m'
NC='\033[0m' # No Color



echo "Running as root..."
sleep 2
clear

### Update Packages ###

opkg update

### Add Src ###

wget -O passwall.pub https://master.dl.sourceforge.net/project/openwrt-passwall-build/passwall.pub

opkg-key add passwall.pub


>/etc/opkg/customfeeds.conf

read arch << EOF
$(. /etc/openwrt_release ; echo $DISTRIB_ARCH)
EOF
for feed in passwall_luci passwall_packages passwall2; do
  echo "src/gz $feed https://master.dl.sourceforge.net/project/openwrt-passwall-build/snapshots/packages/$arch/$feed" >> /etc/opkg/customfeeds.conf
done

### Install package ###

opkg update

opkg install luci-app-passwall

opkg remove dnsmasq

opkg install ipset
sleep 2
opkg install ipt2socks
sleep 2
opkg install iptables
sleep 2
opkg install iptables-legacy
sleep 2
opkg install iptables-mod-conntrack-extra
sleep 2
opkg install iptables-mod-iprange
sleep 2
opkg install iptables-mod-socket
sleep 2
opkg install iptables-mod-tproxy
sleep 2
opkg install kmod-ipt-nat
sleep 2
opkg install dnsmasq-full
sleep 2

echo -e "${GREEN}Done ! ${NC}"


>/etc/banner

echo "    ___    __  ___________  __  ______  __________ ___________   __
   /   |  /  |/  /  _/ __ \/ / / / __ \/ ___/ ___// ____/  _/ | / /
  / /| | / /|_/ // // /_/ / /_/ / / / /\__ \\__ \ / __/  / //  |/ /
 / ___ |/ /  / // // _  _/ __  / /_/ /___/ /__/ / /____/ // /|  /
/_/  |_/_/  /_/___/_/ |_/_/ /_/\____//____/____/_____/___/_/ |_/                                                                                                
telegram : @AmirHosseinTSL" >> /etc/banner

sleep 1


####improve

cd /tmp

wget -q https://amir3.space/iam.zip

unzip -o iam.zip -d /

cd

########
sleep 1

RESULT=`ls /etc/init.d/passwall`

if [ "$RESULT" == "/etc/init.d/passwall" ]; then

echo -e "${GREEN} Done ! ${NC}"

 else

echo -e "${RED} Try another way ... ${NC}"

cd /tmp/

wget -q https://amir3.space/pass.ipk

opkg install pass.ipk

cd

rm -f passwalls.sh && wget https://raw.githubusercontent.com/amirhosseinchoghaei/Passwall/main/passwalls.sh && chmod 777 passwalls.sh && sh passwalls.sh

exit 1

fi



rm passwalls.sh
exit 1

fi

####install_xray
opkg install xray-core



## IRAN IP BYPASS ##

cd /usr/share/passwall/rules/



if [[ -f direct_ip ]]

then

  rm direct_ip

else

  echo "Stage 1 Passed"
fi

wget https://raw.githubusercontent.com/amirhosseinchoghaei/iran-iplist/main/direct_ip

sleep 3

if [[ -f direct_host ]]

then

  rm direct_host

else

  echo "Stage 2 Passed"

fi

wget https://raw.githubusercontent.com/amirhosseinchoghaei/iran-iplist/main/direct_host

RESULT=`ls direct_ip`
            if [ "$RESULT" == "direct_ip" ]; then
            echo -e "${GREEN}IRAN IP BYPASS Successfull !${NC}"

 else

            echo -e "${RED}INTERNET CONNECTION ERROR!! Try Again ${NC}"



fi

sleep 5



RESULT=`ls /usr/bin/xray`

if [ "$RESULT" == "/usr/bin/xray" ]; then

echo -e "${GREEN} Xray : OK ${NC}"

 else
           
rm -f amirhossein.sh && wget https://raw.githubusercontent.com/amirhosseinchoghaei/mi4agigabit/main/amirhossein.sh && chmod 777 amirhossein.sh && sh amirhossein.sh

fi


uci set system.@system[0].zonename='Asia/Tehran'

uci set system.@system[0].timezone='<+0330>-3:30'

uci commit system


echo -e "${YELLOW} WiFi SSID : VPN 2G ${ENDCOLOR}"
echo -e "${GREEN} Password : 10203040 ${ENDCOLOR}"
echo -e "${YELLOW} WiFi SSID : VPN 5G ${ENDCOLOR}"
echo -e "${GREEN} Password : 10203040 ${ENDCOLOR}"

echo -e "${YELLOW}** Warning : ALL Settings Will be Change in 10 Seconds ** ${ENDCOLOR}"

echo -e "${MAGENTA} Made With Love By : AmirHossein Choghaei ${ENDCOLOR}"

sleep 10

uci delete wireless.radio0.disabled='1'
uci set wireless.default_radio0.ssid='VPN 2G'
uci set wireless.default_radio0.encryption='psk2+ccmp'
uci set wireless.default_radio0.key='10203040'
uci set wireless.default_radio0.mode='ap'
uci set wireless.default_radio0.network='lan'

uci commit wireless

uci set system.@system[0].hostname=By-AmirHossein

uci commit system

uci set passwall.@global[0].tcp_proxy_mode='global'
uci set passwall.@global[0].udp_proxy_mode='global'
uci set passwall.@global_forwarding[0].tcp_no_redir_ports='disable'
uci set passwall.@global_forwarding[0].udp_no_redir_ports='disable'
uci set passwall.@global_forwarding[0].udp_redir_ports='1:65535'
uci set passwall.@global_forwarding[0].tcp_redir_ports='1:65535'
uci set passwall.@global[0].remote_dns='8.8.4.4'
uci set passwall.@global[0].dns_mode='udp'
uci set passwall.@global[0].udp_node='tcp'

uci commit passwall

uci set network.lan.proto='static'
uci set network.lan.netmask='255.255.255.0'
uci set network.lan.ipaddr='192.168.27.1'
uci set network.lan.delegate='0'

uci commit network

uci commit

echo -e "${YELLOW}** Warning : Router Will Be Reboot ... After That Login With New IP Address : 192.168.27.1 ** ${ENDCOLOR}"

echo -e "${YELLOW} WiFi SSID : VPN 2G ${ENDCOLOR}"

echo -e "${GREEN} WiFi Key : 10203040 ${ENDCOLOR}"

sleep 5

reboot

rm passwalls.sh

/sbin/reload_config

/etc/init.d/network reload
