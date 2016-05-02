#!/bin/bash
DIFFPATH="/var/lib/docker/aufs/diff"
touch /tmp/mount.txt
#du -s $DIFFPATH/* | grep -v init > /tmp/diff.txt 
while read -r mount_size mount_dir; do
   if (( $mount_size > 500000 )); then
      mount_file=$(basename $mount_dir)
      #mount_grep=$(grep -v init-id -R $mount_file /var/lib/docker/image/aufs/layerdb/* | awk  -F  ":" '{print $1}')
      mount_grep=$(grep -R $mount_file /var/lib/docker/image/aufs/layerdb/* | grep -v "init-id" | awk  -F  ":" '{print $1}' )
      mount_id=$(echo $mount_grep | awk -F "/" '{print $9}')
      mount_type=$(echo $mount_grep | awk -F "/" '{print $10}')
      if [ $mount_type = "mount-id" ]; then
    echo $mount_id $mount_size
    docker diff $mount_id
      fi
   fi
done < /tmp/diff.txt 

