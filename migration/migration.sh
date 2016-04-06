#!/bin/bash
for container in `cat $1`
do
   echo  $container
   container_image=${container:0:32}
   docker commit $container backup/$container_image
   docker tag backup/$container_image registry.codepicnic.com:5000/backup/$container_image
   docker push registry.codepicnic.com:5000/backup/$container_image
done
