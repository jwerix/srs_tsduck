SRS build with tsduck, mediainfo, srt
===================

*STATUS*:

------------------
 - This is a fork from https://github.com/zimbatm/ffmpeg-static made by zimbatm etc... 
 - This docker file is built for ubuntu 18.04 bionic 
 - latest modification add supervisor to start srs, api at 8085 and rtmp2ts, tsduck (disabled by default for the moment)
 
Checkout from git and build docker with srs
---------------
    $ docker build -t <s1> .
    $ docker run -it -p 1935:1935 -p 1985:1985 -p 8080:8080 -p 8085:8085 <s1> bash 
    $ docker run -it --env-file srs/srs.env --entrypoint="./srs.entrypoint.sh" -p 1935:1935 -p 1985:1985 -p 8080:8080 -p 8085:8085 -d s1:latest 
    $ 
    $
    $# /tmp/srs/trunk/research/api-server# python server.py 8085 & 
    $# cd /tmp/srs/trunk && ./objs/srs -c conf/console.conf 
    $ source stream e.g ffmpeg -re -i myfavouritevideo.mkv -c copy -f flv rtmp://192.168.1.xxx/live/livestream  
    $ open with a web browser on http://192.168.1.xxx:8085/ to see streaming on web 

### TODO
 * srt is not able to be compiled with ffmpeg in static mode --enable-libsrt not working 

Related projects
----------------
* FFmpeg Static Builds - http://johnvansickle.com/ffmpeg/

License
-------
This project is licensed under the ISC. See the [LICENSE](LICENSE) file for
the legalities.

### bigmac.tar.gz contains:

wei@pv105-ub1804:~/srs_tsduck$ tar tvf bigmac.tar.gz 
-rwxrwxr-x wei/wei    46040416 2020-05-12 17:00 bin/ffmpeg
-rwxrwxr-x wei/wei    45930016 2020-05-12 17:00 bin/ffprobe
-rwxrwxr-x wei/wei          82 2020-05-14 16:51 srs/api.service.sh
-rw-rw-r-- wei/wei         211 2020-05-14 13:49 srs/api.supervisor.conf
-rw-rw-r-- wei/wei        1284 2020-05-14 16:34 srs/main.conf.template
-rw-rw-r-- wei/wei         211 2020-05-14 16:51 srs/srs.api.conf
-rw-rw-r-- wei/wei        1647 2020-05-14 13:00 srs/srs.conf
-rwxrwxr-x wei/wei        3604 2020-05-15 09:33 srs/srs.entrypoint.sh
-rw-rw-r-- wei/wei         485 2020-05-14 18:11 srs/srs.env
-rwxrwxr-x wei/wei          61 2020-05-14 13:30 srs/srs.service.sh
-rw-rw-r-- wei/wei         640 2020-05-14 15:52 srs/srs.supervisor.conf.template
-rw-rw-r-- wei/wei         217 2020-05-14 17:22 tsduck/rtmp.env
-rw-rw-r-- wei/wei         483 2020-05-14 17:46 tsduck/rtmp2ts.conf.template
-rwxrwxr-x wei/wei         503 2020-05-14 17:20 tsduck/rtmp2ts.service.sh
-rw-rw-r-- wei/wei         366 2020-05-14 17:51 tsduck/tsduck.conf.template
-rw-rw-r-- wei/wei           3 2020-05-14 17:22 tsduck/tsduck.env
-rwxrwxr-x wei/wei         127 2020-05-14 17:57 tsduck/tsduck.service.sh
wei@pv105-ub1804:~/srs_tsduck$ 
