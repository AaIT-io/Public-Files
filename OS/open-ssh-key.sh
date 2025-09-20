#!/bin/bash


# 虚拟化平台默认没有打开SSH密钥登录用命令打开下


sed -i 's/^#\?PubkeyAuthentication.*/PubkeyAuthentication yes/' /etc/ssh/sshd_config
systemctl restart sshd
