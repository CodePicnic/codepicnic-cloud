#!/bin/bash
aws ec2 describe-instances --region us-east-1 --query 'Reservations[].Instances[].[InstanceId]' --output text > /tmp/ec2.instances
while read instance_id 
do
    ami_name="$instance_id"-$(date +%Y-%m-%d --date '7 days ago')
    ami_id=$(aws ec2 describe-images --owners self --region us-east-1 --query 'Images[].[ImageId]' --filters "Name=name,Values=$ami_name" --output text)
    if [[ $ami_id == ami* ]]; then
    echo "$ami_name -  $ami_id"
    snapshots=($(aws ec2 describe-images --image-ids $ami_id --region us-east-1  --output text --query 'Images[*].BlockDeviceMappings[*].Ebs.[SnapshotId]'))
        aws ec2 deregister-image --region us-east-1 --image-id $ami_id
    for snapshot_id in "${snapshots[@]}"
    do
        echo $snapshot_id
        aws ec2 delete-snapshot --snapshot-id $snapshot_id --region us-east-1 
    done
    fi
    ##aws ec2 deregister-image --region us-east-1 --image-id "$instance_id"-$(date +%Y-%m-%d --date '10 days ago') 

done <  /tmp/ec2.instances

