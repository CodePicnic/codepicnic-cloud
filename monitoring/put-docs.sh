#!/bin/bash
md_file=$1
tmp_file=/tmp/servers.ec2
echo "## Swarm Production" > $md_file
echo "|  Name | Internal IP  | Public IP  | Instance ID |" >> $md_file
echo "|---|---|---|---|" >> $md_file
aws ec2 describe-instances --region us-east-1 --filters "Name=tag:aws:autoscaling:groupName,Values=asg-swarm-01" "Name=instance-state-name,Values=running"  --query 'Reservations[].Instances[].[PublicIpAddress,PrivateIpAddress,InstanceId]' --output text > $tmp_file 
while read public_ip private_ip instance_id 
do
    echo "| Swarm Node  | $private_ip  |  $public_ip  | $instance_id" >> $md_file
done < $tmp_file 
aws ec2 describe-instances --region us-east-1 --filters "Name=tag:Name,Values=swarm-master" "Name=instance-state-name,Values=running"  --query 'Reservations[].Instances[].[PublicIpAddress,PrivateIpAddress,InstanceId]' --output text > $tmp_file 
while read public_ip private_ip instance_id 
do
    echo "| Swarm Master  | $private_ip  |  $public_ip  | $instance_id" >> $md_file
done < $tmp_file 
echo "## Swarm Staging" >> $md_file
echo "|  Name | Internal IP  | Public IP  | Instance ID |" >> $md_file
echo "|---|---|---|---|" >> $md_file
aws ec2 describe-instances --region us-east-1 --filters "Name=tag:Name,Values=swarm-micro-node" "Name=instance-state-name,Values=running"  --query 'Reservations[].Instances[].[PublicIpAddress,PrivateIpAddress,InstanceId]' --output text > $tmp_file 
while read public_ip private_ip instance_id 
do
    echo "| Swarm Node  | $private_ip  |  $public_ip  | $instance_id" >> $md_file
done < $tmp_file 
aws ec2 describe-instances --region us-east-1 --filters "Name=tag:Name,Values=swarm-micro-master" "Name=instance-state-name,Values=running"  --query 'Reservations[].Instances[].[PublicIpAddress,PrivateIpAddress,InstanceId]' --output text > $tmp_file 
while read public_ip private_ip instance_id 
do
    echo "| Swarm Master  | $private_ip  |  $public_ip  | $instance_id" >> $md_file
done < $tmp_file 

aws ec2 describe-instances --region us-east-1 --filters "Name=tag:Project,Values=codepicnic-prod" "Name=instance-state-name,Values=running"  --query 'Reservations[].Instances[].[PublicIpAddress,PrivateIpAddress,InstanceId,Tags[?Key==`Name`].Value | [0]]' --output text > $tmp_file 
echo "## Codepicnic Production" >> $md_file
echo "|  Name | Internal IP  | Public IP  | Instance ID |" >> $md_file
echo "|---|---|---|---|" >> $md_file
while read public_ip private_ip instance_id name
do
    echo "| $name  | $private_ip  |  $public_ip  | $instance_id" >> $md_file
done < $tmp_file 
