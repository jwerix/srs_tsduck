#!/bin/sh

# srs server config modification
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

# rtmp2ts and tsduck config modification

mkfifo /videofifo.ts

sed -e "s/_BITRATE_/${BITRATE}/g" -e "s/_STREAMING_ADDR_/${STREAMING_ADDR}/g"  -e "s/_RTMP_PORT_/${RTMP_PORT}/g"   -e "s/_MPEGTS_START_PID_/${MPEGTS_START_PID}/g"  -e "s/_STREAMKEY_/${STREAMKEY}/g" -e "s/_SERVICE_NAME_/${SERVICE_NAME}/g" -e "s/_SERVICE_PROVIDER_/${SERVICE_PROVIDER}/g"   /etc/supervisor/conf.d/rtmp2ts.conf.template > /etc/supervisor/conf.d/rtmp2ts.conf
# disable for the moment
#sed -e "s/_BITRATE_/${BITRATE}/g" -e "s/_MULTICAST_ADDR_/${MULTICAST_ADDR}/g" -e "s/_OUTGOING_ADDR_/${OUTGOING_ADDR}/g" -e "s/_TSUDP_PORT_/${TSUDP_PORT}/g"  -e "s/_TTL_/${TTL}/g"   /etc/supervisor/conf.d/tsduck.conf.template > /etc/supervisor/conf.d/tsduck.conf


exec /usr/bin/supervisord -n
