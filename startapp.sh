FROM jlesage/baseimage:debian-8
ADD mangoszero_debian8_64bit.tar.bz2 /config/
RUN apt-get update && apt-get install -y libssl1.0.0 libmysqlclient18 && apt-get autoclean
# 设置环境变量.
ENV APP_NAME=mangoszero_test \
    MYSQL_ADDRESS=172.17.0.3 \
    MYSQL_PORT=3306 \
    MYSQL_USER=wow60 \
    MYSQL_PASSWD=12345678 \
    MYSQL_REALMD_DBNAME=wow60_realmd \
    MYSQL_WORLD_DBNAME=wow60_mangos \
    MYSQL_CHARACTER_DBNAME=wow60_character
EXPOSE 3724 8085
COPY startapp.sh /startapp.sh
#RUN apt-get update && apt-get install -y build-essential gcc g++ automake autoconf make patch libmysql++-dev libtool libssl-dev grep binutils zlibc libc6 libbz2-dev cmake subversion libboost-all-dev && apt-get autoclean
