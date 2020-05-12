FFmpeg static build
===================

*STATUS*: 
------------------
 - This is a fork from https://github.com/zimbatm/ffmpeg-static made by BlackHole1 
 - This docker file is built for ubuntu 18.04 bionic 

 - upgrade rtmpdump/rtmplib with openssl
 - upgrade openssl 1.1.1g
 - upgrade ffmpeg to the latest master branch
 - upgrade libxml2 to the latest master branch
 
Build in docker and copy binary to external system
---------------
    $ docker build -t ffmpeg-static .
    $ docker run -it ffmpeg-static
    $ ./build.sh [-j <jobs>] [-B] [-d]
	$ docker cp <runningDocker>:/ffmpeg/bin/ffmpeg . 
	$ docker cp <runningDocker>:/ffmpeg/bin/ffprobe . 
	$ docker cp <runningDocker>:/ffmpeg/target/bin/srt-ffplay . 

### TODO
 * srt is not able to be compiled with ffmpeg in static mode --enable-libsrt not working 
 * mediainfo  
 * tsduck
 * srs 

Related projects
----------------
* FFmpeg Static Builds - http://johnvansickle.com/ffmpeg/

License
-------
This project is licensed under the ISC. See the [LICENSE](LICENSE) file for
the legalities.

