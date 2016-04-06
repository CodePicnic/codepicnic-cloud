#!/bin/bash
while true
do
    echo "Press [CTRL+C] to stop.."
    name=$(date +%s | md5sum | awk '{ print $1 }')
    start=$(date +%s.%N)
    docker -H :4000 run -m 256m -d -e STOP_URL="http://codepicnic.com/consoles/206238/heartbeat" --net net-swarm-01 --expose 15000 --name $name codepicnic/base_20151201
    cmd_run=$(echo "$(date +%s.%N) - $start" | bc)
    start=$(date +%s.%N)
    running=$(docker -H :4000 ps | wc -l)
    cmd_ps=$(echo "$(date +%s.%N) - $start" | bc)
    echo "run: $cmd_run"
    echo "ps: $cmd_ps"
    echo "running: $running"
    curl -i -XPOST 'http://localhost:8086/write?db=swarm' --data-binary "command run=$cmd_run,ps=$cmd_ps,running=$running"

done
