#!/bin/bash
#export HOME=/etc/service/mangoszero
chmod 777 /etc/service/mangoszero/*
# 删除并重建配置文件
rm -rf /etc/service/mangoszero/etc/realmd.conf
cp -r /etc/service/mangoszero/etc/realmd.conf.dist /etc/service/mangoszero/etc/realmd.conf
sed -i "s/127.0.0.1;3306;mangos;mangos;realmd/${MYSQL_ADDRESS};${MYSQL_PORT};${MYSQL_USER};${MYSQL_PASSWD};${MYSQL_REALMD_DBNAME};/g" /etc/service/mangoszero/etc/realmd.conf
# /etc/service/mangoszero/bin/realmd -c /etc/service/mangoszero/etc/realmd.conf &
cd /etc/service/mangoszero/bin/ && ./realmd &
sleep 3
sed -i '/AiPlayerbot.Enabled /c AiPlayerbot.Enabled = 0' /etc/service/mangoszero/etc/aiplayerbot.conf
rm -rf /etc/service/mangoszero/etc/mangosd.conf
cp -r /etc/service/mangoszero/etc/mangosd.conf.dist /etc/service/mangoszero/etc/mangosd.conf
sed -i "s/127.0.0.1;3306;root;mangos;realmd/${MYSQL_ADDRESS};${MYSQL_PORT};${MYSQL_USER};${MYSQL_PASSWD};${MYSQL_REALMD_DBNAME};/g" /etc/service/mangoszero/etc/mangosd.conf
sed -i "s/127.0.0.1;3306;root;mangos;mangos0/${MYSQL_ADDRESS};${MYSQL_PORT};${MYSQL_USER};${MYSQL_PASSWD};${MYSQL_WORLD_DBNAME};/g" /etc/service/mangoszero/etc/mangosd.conf
sed -i "s/127.0.0.1;3306;root;mangos;character0/${MYSQL_ADDRESS};${MYSQL_PORT};${MYSQL_USER};${MYSQL_PASSWD};${MYSQL_CHARACTER_DBNAME};/g" /etc/service/mangoszero/etc/mangosd.conf
sed -i '/DataDir                      = /c DataDir                      = "/etc/service/mangoszero/data"' /etc/service/mangoszero/etc/mangosd.conf
sleep 3
cd /etc/service/mangoszero/bin/
./mangosd
