#!/bin/bash
echo "Fireshonks Workshop"
for i in $(seq 0 3); do
curl -s "https://pretalx.c3voc.de/fire-shonks-2022/schedule/export/schedule.json" | jq '.[] | .conference.days|.['$i'].rooms|.["Fireshonks-Workshop"]|.[]|.title' | awk '{print $0 "\n" "?" "start=1000" "&" "end=5000" "&" "day=" '$i' "&" "track=" NR-1 "&" "room=Fireshonks%20Workshop" "\n" "---------------------"}'
done
echo "#####################"
echo ""
echo "#####################"
echo "Fireshonks-Stream"
for i in $(seq 0 3); do
curl -s "https://pretalx.c3voc.de/fire-shonks-2022/schedule/export/schedule.json" | jq '.[] | .conference.days|.['$i'].rooms|.["Fireshonks-Stream"]|.[]|.title' | awk '{print $0 "\n" "?" "start=1000" "&" "end=5000" "&" "day=" '$i' "&" "track=" NR-1 "&" "room=Fireshonks-Stream" "\n" "---------------------"}'
done
