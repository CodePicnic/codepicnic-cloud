#!/bin/bash
for container in `docker ps --no-trunc -q`; do
  mount=$(cat /var/lib/docker/image/aufs/layerdb/mounts/$container/mount-id)
  size=`du -ks /var/lib/docker/aufs/diff/$mount| cut -f 1`
  if (( size > 1000000 )); then
    container_name=$(docker inspect --format='{{.Name}}' $container)
    echo "${container_name:1:${#container_name}-2}" - $size 
  fi
done

