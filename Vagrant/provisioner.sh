#!/bin/sh

# cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
timedatectl set-timezone Asia/Shanghai
systemctl restart network

mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
curl http://ThinkPad-P50/centos/CentOS7-Base-163-mod.repo -o /etc/yum.repos.d/CentOS7-Base-163-mod.repo
curl http://ThinkPad-P50/ambari/centos7/2.x/updates/2.6.0.0/ambari.repo -o /etc/yum.repos.d/ambari.repo
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
yum -y install glibc-common ntpdate
localedef --list-archive | egrep -v -i "zh_CN|en_US" | xargs localedef --delete-from-archive
mv -f /usr/lib/locale/locale-archive /usr/lib/locale/locale-archive.tmpl
build-locale-archive
localectl set-locale LANG=zh_CN.utf8

# echo "25/* * * * * /usr/sbin/ntpdate 2.cn.pool.ntp.org" > /var/spool/cron/vagrant
echo "25/* * * * * root /usr/sbin/ntpdate 120.25.115.19" >> /etc/crontab

echo "export JAVA_HOME=/vagrant/jdk1.7.0_80" >> /etc/profile
echo "export CLASSPATH=.:\$JAVA_HOME/lib/dt.jar:\$JAVA_HOME/lib/tools.jar" >> /etc/profile
echo "export PATH=\$PATH:\$JAVA_HOME/bin" >> /etc/profile

chmod u+x /vagrant/jdk1.7.0_80/bin/*
chmod u+x /vagrant/jdk1.7.0_80/jre/bin/*

source /etc/profile


# curl http://mirrors.163.com/.help/CentOS7-Base-163.repo -o /etc/yum.repos.d/CentOS7-Base-163.repo
