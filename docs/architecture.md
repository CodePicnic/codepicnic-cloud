# CodePicnic Architecture Overview

## Cloud Infrastructure

![CodePicnic Cloud Infrastructure](cloud_architecture.png)

### Components

* ELB *.codepicnic.com (elb-swarm-01)

This component provides load balancing and SSL termination for the CodePicnic consoles.

* ELB codepicnic.com

This component provides load balancing (not in use yet) and SSL termination for the CodePicnic application.

* ELB tuna.codepicnic.com

This component provides load balancing (not in use yet) and SSL termination for the Tuna application.

* Swarm Nodes

EC2 instances where the containers are distributed. 

* Swarm Master

EC2 instances where the Swarm master is running.

* Swarm Autoscaling



* CodePicnic Server
* Deployment Server
* DNS
* S3
* NewRelic
