FROM debian:latest

RUN apt-get update && apt-get install -y autoconf libtool g++ gcc-multilib bison libtool 

RUN echo 'deb http://ftp.us.debian.org/debian/ testing main contrib non-free' >> /etc/apt/sources.list

RUN apt-get update && apt-get install -y -t testing libc6

ADD ./bin /bin/
ADD ./PMNEWS /root
ADD ./start.sh /

ENTRYPOINT ["/start.sh", "-p", "/bin/php7/bin/php", "-f", "/root/PocketMine-MP.phar"]

