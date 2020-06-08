#!/bin/bash

/usr/bin/tsp -v -I file /videofifo.ts -P pcrbitrate --min-pcr ${min-pcr} -P regulate -O ip --enforce-burst --packet-burst 7 --local-address ${LOCAL-IP} --rtp ip ${IP}:${PORT}
