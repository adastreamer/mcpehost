FROM debian:latest

RUN apt-get update && apt-get install -y autoconf libtool g++ gcc-multilib bison libtool 

RUN echo 'deb http://ftp.us.debian.org/debian/ testing main contrib non-free' >> /etc/apt/sources.list

RUN apt-get update && apt-get install -y -t testing libc6

VOLUME /root

ADD ./bin /bin/

# the work dir which is going to be the persistent
# and being populated on the first launch
# the logic of this behaviour is in the run.sh script
ADD ./PMNEWS /root

# the initial data for work dir
ADD ./PMNEWS /PMNEWS

ADD ./run.sh /
ADD ./start.sh /

CMD ["/run.sh"]

