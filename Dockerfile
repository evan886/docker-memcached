FROM evan886/ubuntu14
MAINTAINER evan <evan886@gmail.com>

#RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak 
#ADD  ./14.04.list /etc/apt/

# Install Memcached 1.5.22
RUN apt-get  update 
RUN DEBIAN_FRONTEND=noninteractive && \
    apt-get install -y  \
    libevent-dev \
    libsasl2-2 \
    sasl2-bin \
    libsasl2-2 \
    libsasl2-dev \
    wget \
    pwgen \
    gcc \
    make \
    libsasl2-modules && \
    cd /tmp && \
    wget http://memcached.org/files/memcached-1.4.38.tar.gz && \
    tar xvf memcached-1.4.38.tar.gz && \
    cd memcached-1.4.38 && \
    apt-get install -y  libevent-dev && \
    ./configure --enable-sasl && \
    make -j2 && \
    make install && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add scripts
ADD scripts /scripts
RUN chmod +x /scripts/*.sh
RUN touch /.firstrun
RUN chown daemon:daemon /etc/sasldb2

# Command to run
ENTRYPOINT ["/scripts/run.sh"]
CMD [""]

# Expose listen port
EXPOSE 11211
