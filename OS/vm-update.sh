#!/bin/bash


# 仅用于生成环境虚拟机


# --- 允许SSH密钥登录 ---
sed -i 's/^#\?PubkeyAuthentication.*/PubkeyAuthentication yes/' /etc/ssh/sshd_config
sleep 3s && systemctl restart sshd


# 检测系统并执行对应更新命令
if [ -f /etc/redhat-release ]; then
    # CentOS 系统（兼容7/8）
    bash <(curl -sSL https://linuxmirrors.cn/main.sh) \
        --source mirrors.aliyun.com \
        --protocol http \
        --use-intranet-source false \
        --install-epel true \
        --backup false \
        --upgrade-software false \
        --clean-cache false \
        --ignore-backup-tips
# Debian 11 系统
elif [ -f /etc/debian_version ] && grep -q '^11' /etc/debian_version; then
    # 直接替换为Linode的软件源
    cat > /etc/apt/sources.list << EOF
deb http://mirrors.linode.com/debian bullseye main
deb-src http://mirrors.linode.com/debian bullseye main

deb http://mirrors.linode.com/debian-security bullseye-security/updates main
deb-src http://mirrors.linode.com/debian-security bullseye-security/updates main

deb http://mirrors.linode.com/debian bullseye-updates main
deb-src http://mirrors.linode.com/debian bullseye-updates main
EOF
    apt update -y
fi

