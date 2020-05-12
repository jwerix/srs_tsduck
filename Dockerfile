#------------------------------------------------------------------------------------
#--------------------------dist------------------------------------------------------
#------------------------------------------------------------------------------------
FROM ubuntu:bionic as dist

RUN apt-get update && \
    apt-get install -y aptitude gcc g++ make patch unzip python git vim \
        autoconf automake libtool pkg-config libxml2-dev liblzma-dev curl net-tools \
        cmake extra-cmake-modules mediainfo openssl1.0 libssl1.0-dev libpthread-stubs0-dev 

RUN mkdir -p /usr/lib64
# copy binary
COPY bin/ffmpeg /usr/local/bin/ffmpeg
COPY bin/ffprobe /usr/local/bin/ffprobe

ENV PATH $PATH:/bin
ENV PKG_CONFIG_PATH /usr/local/lib/pkgconfig:/usr/local/lib64/pkgconfig


# Build srt
RUN cd /tmp && git clone --depth 1 https://github.com/Haivision/srt.git && \
cd srt && \
cmake . -DENABLE_LOGGING=1 -DENABLE_APPS=1 -DENABLE_CODE_COVERAGE=1 -DENABLE_CXX_DEPS=1  -DENABLE_PKTINFO=1 -DENABLE_PROFILE=1 -DUSE_STATIC_LIBSTDCXX=1 -DENABLE_RELATIVE_LIBPATH=1 && \
make -j 4&& make install

# Build tsduck
RUN cd /tmp && git clone https://github.com/tsduck/tsduck.git && cd tsduck && ./build/install-prerequisites.sh && \
make -j 4 NOPCSC=1 NOCURL=1 NODTAPI=1 NOSRT=0 NOTEST=1 && \
make install

# Build go
ENV PATH $PATH:/usr/local/go/bin
RUN cd /usr/local && \
    curl -L -O https://dl.google.com/go/go1.13.5.linux-amd64.tar.gz && \
    tar xf go1.13.5.linux-amd64.tar.gz && \
    rm -f go1.13.5.linux-amd64.tar.gz

# Build srs
RUN cd /tmp && git clone https://github.com/ossrs/srs.git && \
cd /tmp/srs && git checkout 4.0release && \
cd /tmp/srs/trunk && ./configure && \
make -j 4 &&  make install

#Cleaning up
RUN rm -rf /usr/local/go/src && rm -rf /tmp/srs/trunk/doc && rm -rf /tmp/srs/trunk/src && \
rm -rf /tmp/srs/trunk/3rdparty/*.zip && \
rm -rf /tmp/srs/trunk/3rdparty/*.tar.gz && \
rm -rf /tmp/srt && rm -rf /tmp/tsduck && \
rm -rf /var/lib/apt/lists/*

WORKDIR /tmp/srs

