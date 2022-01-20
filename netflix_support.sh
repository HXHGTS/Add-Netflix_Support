#!/bin/sh
echo 正在安装wireguard. . .
echo 13.35.162.73 download.copr.fedorainfracloud.org > /etc/hosts
echo 38.145.60.24 dl.fedoraproject.org >> /etc/hosts
yum install net-tools.x86_64 -y
yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm -y
curl -o /etc/yum.repos.d/jdoss-wireguard-epel-7.repo https://raw.githubusercontent.com/HXHGTS/Add-Netflix_Support/main/jdoss-wireguard-epel-7.repo
yum install wireguard-dkms wireguard-tools -y
wget https://github.com/ViRb3/wgcf/releases/download/v2.2.8/wgcf_2.2.8_linux_amd64 -O /etc/wireguard/wgcf_2.2.8_linux_amd64
cd /etc/wireguard && chmod +x wgcf_2.2.8_linux_amd64
echo 正在注册WARP账号. . .
echo yes | ./wgcf_2.2.8_linux_amd64 register
./wgcf_2.2.8_linux_amd64 generate
echo [Interface] > /etc/wireguard/wgcf.conf
cat /etc/wireguard/wgcf-profile.conf | grep "PrivateKey" >> /etc/wireguard/wgcf.conf
echo Address = 172.16.0.2/32 >> /etc/wireguard/wgcf.conf
echo DNS = 1.1.1.1,1.0.0.1 >> /etc/wireguard/wgcf.conf
echo MTU = 1280 >> /etc/wireguard/wgcf.conf
echo Table = off >> /etc/wireguard/wgcf.conf
echo PostUP = ip -4 rule add from 172.16.0.2 lookup 51820 >> /etc/wireguard/wgcf.conf
echo PostUP = ip -4 route add default dev wgcf table 51820 >> /etc/wireguard/wgcf.conf
echo PostUP = ip -4 rule add table main suppress_prefixlength 0 >> /etc/wireguard/wgcf.conf
echo PostDown = ip -4 rule delete from 172.16.0.2/32 lookup 51820 >> /etc/wireguard/wgcf.conf
echo PostDown = ip -4 rule delete table main suppress_prefixlength 0 >> /etc/wireguard/wgcf.conf
echo [Peer] >> /etc/wireguard/wgcf.conf
echo AllowedIPs = 0.0.0.0/0 >> /etc/wireguard/wgcf.conf
cat /etc/wireguard/wgcf-profile.conf | grep "PublicKey" >> /etc/wireguard/wgcf.conf
echo Endpoint = 162.159.192.1:2408 >> /etc/wireguard/wgcf.conf
systemctl start wg-quick@wgcf && systemctl enable wg-quick@wgcf
echo 安装成功，请修改xray/v2ray配置文件后手动运行！
echo 出口ip:
echo -------------------------
curl ifconfig.me/ip --interface 172.16.0.2
echo
echo -------------------------
exit 0

