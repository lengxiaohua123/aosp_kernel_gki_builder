#!/bin/bash

#以下命令即都是在chroot环境中
#修改阿里源
cat > /etc/apt/sources.list << EOF
deb https://mirrors.aliyun.com/ubuntu-ports/ jammy main restricted universe multiverse
deb-src https://mirrors.aliyun.com/ubuntu-ports/ jammy main restricted universe multiverse

deb https://mirrors.aliyun.com/ubuntu-ports/ jammy-security main restricted universe multiverse
deb-src https://mirrors.aliyun.com/ubuntu-ports/ jammy-security main restricted universe multiverse

deb https://mirrors.aliyun.com/ubuntu-ports/ jammy-updates main restricted universe multiverse
deb-src https://mirrors.aliyun.com/ubuntu-ports/ jammy-updates main restricted universe multiverse

# deb https://mirrors.aliyun.com/ubuntu-ports/ jammy-proposed main restricted universe multiverse
# deb-src https://mirrors.aliyun.com/ubuntu-ports/ jammy-proposed main restricted universe multiverse

deb https://mirrors.aliyun.com/ubuntu-ports/ jammy-backports main restricted universe multiverse
deb-src https://mirrors.aliyun.com/ubuntu-ports/ jammy-backports main restricted universe multiverse
EOF
#更新源
apt update && apt upgrade -y
#设置locales
locale-gen en_US.UTF-8
locale-gen zh_CN.UTF-8
#设置中国时区
rm /etc/localtime
ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
#设置hostname
echo 'xiaomi-gemini' > /etc/hostname
#卸载netplan
apt purge netplan.io
#创建用户
useradd -m -s /bin/bash hol
usermod -aG sudo hol
#设置密码
#passwd hol
#安装一些包
apt install man man-db bash-completion vim tmux network-manager chrony openssh-server initramfs-tools --no-install-recommends -y
