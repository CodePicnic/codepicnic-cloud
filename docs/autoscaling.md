## Swarm AutoScaling Overview

Swarm Autoscaling is based on [AWS Auto Scaling Service](https://aws.amazon.com/autoscaling/) for EC2 instances. Our swarm nodes are part of an Auto Scaling Group (asg-swarm-01)

### Setup

Ansible role [swarm-autoscaling](https://github.com/CodePicnic/codepicnic-cloud/tree/master/ansible/roles/swarm-autoscaling/tasks) defines the configuration needed to setup all the components of the autoscaling.

### Components

* Autoscaling Group (asg-swarm-01)

The Auto Scaling group is a group of EC2 instances with the same launch configuration settings. In the ASG is defined the minimum (2) and maximum (10) size of the cluster, vpc settings and the ELB associated with the swarm cluster.

* Launch Configuration (lc-swarm-01)

The Launch configuration is a template used by the Auto Scaling group to launch EC2 instances based on Amazon Machine Image (AMI). CodePicnic uses a previously customized AMI which includes Docker and special configuration needed to run swarm nodes. Additional information like: security groups, instance type, ssh key, etc is included in the Launch Configuration.

Also included is a user-data script used by AWS to run commands only during the first boot cycle when an instance is launched. For the swarm nodes this script will remove previously cached information and initialize node's basic containers: Swarm Agent, CAdvisor and Nginx. This initialization is made using Docker Compose.

* Auto Scaling Policy (asp-lowmemory)

The "Low Memory" auto scaling policy determines that the ASG should scale out with steps of 1 instance when the Cloudwatch alarm associated with this policy is triggered.  In this case, the ASG will launch a new instance with the settings defined in the Launch Configuration.

* Cloudwatch Alarm  (alarm-lowmemory)

The Low Memory alarm checks the average Memory Utilization (%) of the instances in the AutoScaling Group, if this average exceeds the threshold (65%) the auto scaling policy is triggered.

* AWS Memory and Disk monitoring scripts

Cloudwatch doesn't include Memory and Disc metrics for EC2 instances. To monitor memory and disc utilization we need to deploy the [AWS Monitoring Scripts](http://docs.aws.amazon.com/AmazonCloudWatch/latest/DeveloperGuide/mon-scripts.html) in all the swarm instances. The main script (put-mon-data) will send the metrics to Cloudwatch.

