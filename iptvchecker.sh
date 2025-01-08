#!/usr/bin/bash

echo 'exec iptv-checker -o freetv-checker-stream -k -p 5 -t 60000 FreeStreaming.m3u'
sleep 3
iptv-checker -o freetv-checker-stream -k -p 5 -t 60000 FreeStreaming.m3u
echo 'coping online.m3u'
sleep 1
cp freetv-checker-stream/online.m3u stream.m3u8

sleep 2
echo 'iptv-checker -o freetv-checker-tv -k -p 5 -t 60000 Freetv.m3u'
sleep 3
iptv-checker -o freetv-checker-tv -k -p 5 -t 60000 Freetv.m3u
echo 'coping online.m3u'
sleep 1
cp freetv-checker-tv/online.m3u tv.m3u8
 
echo 'Done'

exit 0
