#!/bin/sh
export HOME=/config
chmod 777 /config/*
# 删除并重建配置文件
rm -rf /config/etc/realmd.conf
cp -r /config/etc/realmd.conf.dist /config/etc/realmd.conf
sed -i "s/127.0.0.1;3306;mangos;mangos;realmd/${MYSQL_ADDRESS};${MYSQL_PORT};${MYSQL_USER};${MYSQL_PASSWD};${MYSQL_REALMD_DBNAME};/g" /config/etc/realmd.conf
# /config/bin/realmd -c /config/etc/realmd.conf &
cd /config/bin/ && ./realmd &
sleep 3
sed -i '/AiPlayerbot.Enabled /c AiPlayerbot.Enabled = 0' /config/etc/aiplayerbot.conf
rm -rf /config/etc/mangosd.conf
cp -r /config/etc/mangosd.conf.dist /config/etc/mangosd.conf
sed -i "s/127.0.0.1;3306;root;mangos;realmd/${MYSQL_ADDRESS};${MYSQL_PORT};${MYSQL_USER};${MYSQL_PASSWD};${MYSQL_REALMD_DBNAME};/g" /config/etc/mangosd.conf
sed -i "s/127.0.0.1;3306;root;mangos;mangos0/${MYSQL_ADDRESS};${MYSQL_PORT};${MYSQL_USER};${MYSQL_PASSWD};${MYSQL_WORLD_DBNAME};/g" /config/etc/mangosd.conf
sed -i "s/127.0.0.1;3306;root;mangos;character0/${MYSQL_ADDRESS};${MYSQL_PORT};${MYSQL_USER};${MYSQL_PASSWD};${MYSQL_CHARACTER_DBNAME};/g" /config/etc/mangosd.conf
sed -i '/DataDir                      = /c DataDir                      = "/config/data"' /config/etc/mangosd.conf
cd /config/bin/ && ./mangosd
sleep 60000000000000
