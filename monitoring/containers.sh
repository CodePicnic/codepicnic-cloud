#!/bin/bash
docker -H 172.21.0.51:2375 info > /tmp/running_51
running_51=$(docker -H 172.21.0.51:2375 info | grep Running | awk '{print $2}' | grep -v WARNING)
running_52=$(docker -H 172.21.0.52:2375 info | grep Running | awk '{print $2}' | grep -v WARNING)
echo $running_51 
echo $running_52 
curl -i -XPOST 'http://localhost:8086/write?db=swarm' --data-binary "docker run-ip-172-21-0-52=$running_52,run-ip-172-21-0-51=$running_51"
#curl -i -XPOST 'http://localhost:8086/write?db=codepicnic' --data-binary "command containers=$containers,cost=$cost,price=$price"

