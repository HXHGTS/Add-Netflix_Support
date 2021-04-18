#!/bin/sh
echo 正在安装wireguard. . .
echo 13.35.162.73 download.copr.fedorainfracloud.org > /etc/hosts
echo 38.145.60.24 dl.fedoraproject.org >> /etc/hosts
echo 162.159.192.1 engage.cloudflareclient.com >> /etc/hosts
yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm -y
curl -o /etc/yum.repos.d/jdoss-wireguard-epel-7.repo https://raw.githubusercontent.com/HXHGTS/Add-Netflix_Support/main/jdoss-wireguard-epel-7.repo
yum install wireguard-dkms wireguard-tools -y
wget https://github.com/ViRb3/wgcf/releases/download/v2.2.3/wgcf_2.2.3_linux_amd64 -O /etc/wireguard/wgcf_2.2.3_linux_amd64
cd /etc/wireguard && chmod +x wgcf_2.2.3_linux_amd64
echo 正在注册WARP账号. . .
echo yes | ./wgcf_2.2.3_linux_amd64 register
./wgcf_2.2.3_linux_amd64 generate
echo 运行成功，请修改配置文件后再运行！
exit 0
