#!/bin/sh
echo 正在安装wireguard. . .
apt install dnsutils resolvconf -y
apt-get install wireguard -y
apt-get install -y wireguard-dkms wireguard-tools linux-headers-$(uname -r)
wget https://github.com/ViRb3/wgcf/releases/download/v2.2.8/wgcf_2.2.8_linux_amd64 -O /etc/wireguard/wgcf_2.2.8_linux_amd64
cd /etc/wireguard && chmod +x wgcf_2.2.8_linux_amd64
echo 正在注册WARP账号. . .
echo yes | ./wgcf_2.2.8_linux_amd64 register
./wgcf_2.2.8_linux_amd64 generate
cat /etc/wireguard/wgcf-profile.conf | grep -v "engage.cloudflareclient.com" | grep -v "172.16.0.2/32" | grep -v "0.0.0.0/0" > /etc/wireguard/wgcf.conf
echo Endpoint = 162.159.192.1:2408 >> /etc/wireguard/wgcf.conf
echo 安装成功，请修改xray/v2ray配置文件后手动运行！
exit 0
