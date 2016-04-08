#!/bin/bash
total=$(wc -l $1)
count=0
for container in `cat $1`
do
   count=$((count+1))
   echo  "[$count/$total] - $container"
   container_image=${container:0:32}
   docker commit $container backup/$container_image
   docker tag backup/$container_image registry.codepicnic.com:5000/backup/$container_image
   docker push registry.codepicnic.com:5000/backup/$container_image
done
