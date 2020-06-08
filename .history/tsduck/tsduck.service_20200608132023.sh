#!/bin/bash

/usr/bin/tsp -v -I file /videofifo.ts -P pcrbitrate --min-pcr ${MIN_PCR} -P regulate -O ip --enforce-burst --packet-burst 7 --local-address ${LOCAL_IP} --rtp ip ${TSDUCK_MULTICAST_ADDR}:${PORT}
