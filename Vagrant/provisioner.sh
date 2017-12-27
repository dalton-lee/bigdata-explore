#!/bin/sh

# cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
timedatectl set-timezone Asia/Shanghai

curl http://ThinkPad-P50/ambari/centos7/2.x/updates/2.6.0.0/ambari.repo -o /etc/yum.repos.d/ambari.repo
yum -y install glibc-common ntpdate
localedef --list-archive | egrep -v -i "zh_CN|en_US" | xargs localedef --delete-from-archive
mv -f /usr/lib/locale/locale-archive /usr/lib/locale/locale-archive.tmpl
build-locale-archive
localectl set-locale LANG=zh_CN.utf8

# echo "25/* * * * * /usr/sbin/ntpdate 2.cn.pool.ntp.org" > /var/spool/cron/vagrant
echo "25/* * * * * /usr/sbin/ntpdate 120.25.115.19" > /var/spool/cron/vagrant

echo "export JAVA_HOME=/vagrant/jdk1.7.0_80" >> /etc/profile
echo "export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar" >> /etc/profile
echo "export PATH=$PATH:$JAVA_HOME/bin" >> /etc/profile

source /etc/profile
