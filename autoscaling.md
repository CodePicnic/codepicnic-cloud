## Swarm AutoScaling Overview

Swarm Autoscaling is based on [AWS Auto Scaling Service](https://aws.amazon.com/autoscaling/) for EC2 instances. Our swarm nodes are part of an Auto Scaling Group (asg-swarm-01)

### Components

* Autoscaling Group (asg-swarm-01)
* Launch Configuration (lc-swarm-01)
* Auto Scaling Policy (asp-lowmemory)
* Cloudwatch Alarm 
* AWS Memory and Disk monitoring scripts
