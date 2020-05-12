#------------------------------------------------------------------------------------
#--------------------------dist------------------------------------------------------
#------------------------------------------------------------------------------------
FROM ubuntu:bionic as dist

RUN apt-get update && \
    apt-get install -y aptitude gcc g++ make patch unzip python git libssl-dev \
        autoconf automake libtool pkg-config libxml2-dev liblzma-dev curl net-tools \
        cmake extra-cmake-modules libcurl4-openssl-dev mediainfo 

WORKDIR /tmp/srs

RUN mkdir -p /usr/lib64
# copy binary
COPY bin/ffmpeg /usr/local/bin/ffmpeg
COPY bin/ffprobe /usr/local/bin/ffprobe

COPY lib/libssl.so /usr/local/lib64/libssl.so
COPY lib/libssl.so.1.1 /usr/local/lib64/libssl.so.1.1
COPY lib/libssl.a /usr/local/lib64/libssl.a
COPY lib/libcrypto.so /usr/local/lib64/libcrypto.so
COPY lib/libcrypto.so.1.1 /usr/local/lib64/libcrypto.so.1.1
COPY lib/libcrypto.a  /usr/local/lib64/libcrypto.a

ENV PATH $PATH:/bin
ENV PKG_CONFIG_PATH /usr/local/lib/pkgconfig:/usr/local/lib64/pkgconfig


# Build srt
RUN cd /tmp && git clone --depth 1 https://github.com/Haivision/srt.git && \
cd srt && \ 
cmake . -DCMAKE_INSTALL_PREFIX=/tmp/srs/srt -DENABLE_APPS=1 -DENABLE_CODE_COVERAGE=1 -DENABLE_CXX_DEPS=1  -DENABLE_PKTINFO=1 -DENABLE_PROFILE=1 -DUSE_STATIC_LIBSTDCXX=1 -DENABLE_RELATIVE_LIBPATH=1 &&\
make && make install

# Build tsduck
RUN cd /tmp && git clone https://github.com/tsduck/tsduck.git && cd tsduck && ./build/install-prerequisites.sh \
&&  make NOPCSC=1 NOCURL=1 NODTAPI=1 NOSRT=0 NOTEST=1 \
&&  make install

ENV PATH $PATH:/usr/local/go/bin
RUN cd /usr/local && \
    curl -L -O https://dl.google.com/go/go1.13.5.linux-amd64.tar.gz && \
    tar xf go1.13.5.linux-amd64.tar.gz && \
    rm -f go1.13.5.linux-amd64.tar.gz

# Build srs
RUN cd /tmp && git clone https://github.com/ossrs/srs.git \
&& cd /tmp/srs && git checkout 4.0release \
&& cd /tmp/srs/trunk && ./configure \
	&& make &&  make install



