#!/bin/sh
echo > /etc/sysctl.conf
##
tee -a /etc/sysctl.conf <<EOF
net.ipv6.conf.default.disable_ipv6 = 0
net.ipv6.conf.all.disable_ipv6 = 0
EOF
##
sysctl -p
IPC=$(curl -4 -s icanhazip.com | cut -d"." -f3)
IPD=$(curl -4 -s icanhazip.com | cut -d"." -f4)
##
if [ $IPC == 16 ]
then
    tee -a /etc/sysconfig/network-scripts/ifcfg-eth0 <<-EOF
	IPV6INIT=yes
	IPV6_AUTOCONF=no
	IPV6_DEFROUTE=yes
	IPV6_FAILURE_FATAL=no
	IPV6_ADDR_GEN_MODE=stable-privacy
	IPV6ADDR=2403:6a40:2:1600::$IPD:0000/64
	IPV6_DEFAULTGW=2403:6a40:2:1600::1
	EOF
elif [ $IPC == 17 ]
then
   	tee -a /etc/sysconfig/network-scripts/ifcfg-eth0 <<-EOF
	IPV6INIT=yes
	IPV6_AUTOCONF=no
	IPV6_DEFROUTE=yes
	IPV6_FAILURE_FATAL=no
	IPV6_ADDR_GEN_MODE=stable-privacy
	IPV6ADDR=2403:6a40:2:1700::$IPD:0000/64
	IPV6_DEFAULTGW=2403:6a40:2:1700::1
	EOF
elif [ $IPC == 13 ]
then
   	tee -a /etc/sysconfig/network-scripts/ifcfg-eth0 <<-EOF
	IPV6INIT=yes
	IPV6_AUTOCONF=no
	IPV6_DEFROUTE=yes
	IPV6_FAILURE_FATAL=no
	IPV6_ADDR_GEN_MODE=stable-privacy
	IPV6ADDR=2403:6a40:2:7300::$IPD:0000/64
	IPV6_DEFAULTGW=2403:6a40:2:7300::1
	EOF
else
	echo 'KHONG CO'
fi

service network restart
