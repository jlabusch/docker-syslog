FROM ubuntu:14.04

ENV TERM xterm

RUN apt-get update && \
    apt-get install -y vim less strace tcpdump lsof gdb && \
    apt-get install -y rsyslog && \
    apt-get clean && \
    rm -fr /var/lib/apt/lists/*

RUN sed 's/#$ModLoad imudp/$ModLoad imudp/'                 -i /etc/rsyslog.conf && \
    sed 's/#$UDPServerRun 514/$UDPServerRun 514/'           -i /etc/rsyslog.conf && \
    sed 's/$FileOwner syslog/$FileOwner root/'              -i /etc/rsyslog.conf && \
    sed 's/$PrivDropToUser syslog/#$PrivDropToUser syslog/' -i /etc/rsyslog.conf && \
    sed 's/$PrivDropToGroup syslog/#$PrivDropToGroup syslog/' -i /etc/rsyslog.conf

VOLUME [ "/var/log" ]

CMD [ "rsyslogd", "-n" ]

