#!/usr/bin/env bash
w=$1
ws-url http://localhost:7058; 
ws-createws $1
ws-url https://kbase.us/services/ws; 
for ot in `ws-listobj $w | awk '{if (NR != 1)print $2"_-_"$4}'`; do 
    o=$(echo $ot | sed -r "s/_-_.*$//"); 
    t=$(echo $ot | sed -r "s/^.*_-_//" | sed -r "s/-[0-9]+\.[0-9]+$//"); 
    echo $o $t; 
    ws-get -w $w $o > $o.json; 
    ws-url http://localhost:7058; 
    ws-load $t $o $o.json -w $w; 
    ws-url https://kbase.us/services/ws; 
    rm $o.json;
done;
ws-url http://localhost:7058; 
ws-listobj $w
