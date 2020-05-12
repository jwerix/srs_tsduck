SRS build with tsduck, mediainfo, srt
===================

*STATUS*: 
------------------
 - This is a fork from https://github.com/zimbatm/ffmpeg-static made by BlackHole1 
 - This docker file is built for ubuntu 18.04 bionic 

 
Checkout from git and build docker with srs
---------------
    $ docker build -t srs-labobuild .
    $ docker run -it srs-labobuild 

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

