#!/bin/sh

#listen 10080;
#maxbw 1000000000;
#connect_timeout 4000;
#peerlatency 300;
#recvlatency 300;

sed -e "s/_listen_/${listen}/g" -e "s/_max_connections_/${max_connections}/g" -e "s/_gop_cache_/${gop_cache}/g" \
 -e "s/_queue_length_/${queue_length}/g"   -e "s/_tcp_nodelay_/${tcp_nodelay}/g"   -e "s/_asprocess_/${asprocess}/g"  \
 -e "s/_grace_start_wait_/${grace_start_wait}/g"  -e "s/_grace_final_wait_/${grace_final_wait}/g" \
 -e "s/_srtlisten_/${srtlisten}/g"  -e "s/_srtmaxbw_/${srtmaxbw}/g" \
 -e "s/_connect_timeout_/${connect_timeout}/g"  -e "s/_peerlatency_/${peerlatency}/g" \
 -e "s/_recvlatency_/${recvlatency}/g" \
/tmp/srs/trunk/conf/main.conf.template > /tmp/srs/trunk/conf/main.conf

sed -e "s/_listen_/${listen}/g" -e "s/_max_connections_/${max_connections}/g" -e "s/_gop_cache_/${gop_cache}/g"  \
    -e "s/_queue_length_/${queue_length}/g"   -e "s/_tcp_nodelay_/${tcp_nodelay}/g"   -e "s/_asprocess_/${asprocess}/g" \
    -e "s/_grace_start_wait_/${grace_start_wait}/g"  -e "s/_grace_final_wait_/${grace_final_wait}/g" \
    -e "s/_srtlisten_/${srtlisten}/g"  -e "s/_srtmaxbw_/${srtmaxbw}/g" \
    -e "s/_connect_timeout_/${connect_timeout}/g"  -e "s/_peerlatency_/${peerlatency}/g" \
    -e "s/_recvlatency_/${recvlatency}/g" \
    /etc/supervisor/conf.d/srs.supervisor.conf.template > /etc/supervisor/conf.d/srs.conf


exec /usr/bin/supervisord -n
