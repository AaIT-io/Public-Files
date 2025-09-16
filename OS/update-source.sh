#!/bin/bash


# 自动替换系统软件源为阿里云解决部分发行版官方源停服问题


bash <(curl -sSL https://linuxmirrors.cn/main.sh) \
  --source mirrors.aliyun.com \
  --protocol http \
  --use-intranet-source false \
  --install-epel true \
  --backup false \
  --upgrade-software false \
  --clean-cache false \
  --ignore-backup-tips
