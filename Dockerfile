# version 1.0

FROM ubuntu:16.04
MAINTAINER Jose G. Faisca <jose.faisca@gmail.com>

ARG DEBIAN_FRONTEND=noninteractive

ENV IMAGE namecoin/namecoind-core
ENV RPC_USER rpc
ENV RPC_PASS secret
ENV RPC_ALLOW_IP 127.0.0.1
ENV MAX_CONNECTIONS 15
ENV RPC_PORT 8336
ENV PORT 8334

# -- Install main independencies --
RUN apt-get update \
        && apt-get install -y libboost-all-dev \
        dh-autoreconf curl libcurl4-openssl-dev \
        git apg libboost-all-dev build-essential libtool \
        libevent-dev wget bsdmainutils autoconf \
        apg libqrencode-dev libcurl4-openssl-dev \
        automake make libssl-dev libminiupnpc-dev \
        pkg-config libzmq3-dev
        
# -- Install BerkeleyDB 4.8 (required for the wallet) --
RUN apt-get install -y software-properties-common \
        && add-apt-repository -y ppa:bitcoin/bitcoin \
        && apt-get update \
        && apt-get install -y libdb4.8-dev libdb4.8++-dev

# -- Build Namecoin --
RUN git clone https://github.com/namecoin/namecoin-core.git \
        && cd namecoin-core \
        && ./autogen.sh \
        && ./configure \
        CXXFLAGS="--param ggc-min-expand=1 --param ggc-min-heapsize=32768" \
        --enable-cxx \
        --disable-shared \
        --with-pic \
        --without-gui \
        --enable-upnp-default \
        && make \
        && make install

# -- Change terminal emulator --
RUN echo -e "\nexport TERM=xterm" >> ~/.bashrc

# -- Clean --
RUN cd / \
        && rm -rf /namecoin-core \
        && apt-get autoremove -y \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY run.sh /usr/local/bin/
ENTRYPOINT ["run.sh"]

EXPOSE 8336/tcp 8334/tcp
VOLUME ["/data/namecoin"]
CMD ["/usr/local/bin/namecoind", "-datadir=/data/namecoin", "-printtoconsole"]
