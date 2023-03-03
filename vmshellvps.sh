#!/usr/bin/env bash

if [ -f /etc/redhat-release ]; then
    release="centos"
elif cat /etc/issue | grep -Eqi "debian"; then
    release="debian"
elif cat /etc/issue | grep -Eqi "ubuntu"; then
    release="ubuntu"
elif cat /etc/issue | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
elif cat /proc/version | grep -Eqi "debian"; then
    release="debian"
elif cat /proc/version | grep -Eqi "ubuntu"; then
    release="ubuntu"
elif cat /proc/version | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
fi

# > /dev/null 2>&1
echo "正在安装基础环境..${release}"
if [ "${release}" == "centos" ]; then
    yum update
    yum -y install wget
else
    apt-get update
    apt-get -y install wget
fi


echo "下载脚本..${release}"

mkdir -p /opt/script/cron
wget --no-check-certificate -qO /opt/script/cron/cleanCache.sh https://github.com/FoxBary/smallvps/blob/main/cleanCache.sh
wget --no-check-certificate -qO /opt/script/cron/cleanLog.sh https://github.com/FoxBary/smallvps/blob/main/cleanLog.sh

chmod +x /opt/script/cron/cleanCache.sh
chmod +x /opt/script/cron/cleanLog.sh


crontab -l > /opt/script/cron/tmp
echo "*/3 * * * * sh /opt/script/cron/cleanCache.sh" >> /opt/script/cron/tmp
echo "*/2 * * * * sh /opt/script/cron/cleanlog.sh" >> /opt/script/cron/tmp
crontab /opt/script/cron/tmp

echo "添加完成！"


echo "作者:失落的梦"
echo "VPS小内存清理工具,主要针对VPS的内存不够充裕的情况下，而页面缓存和日志文件等等占用了VPS的硬盘和内存空间，我们解决如何自动清理的问题，该脚本作者:失落的梦"
echo "微信：Falltoher-1314"
echo "QQ： 1150315739"
echo "博客1：https://www.kehu33.asia"
echo "博客2：https://www.vcxm789.asia"
echo "版本: 8.0"

echo ""
