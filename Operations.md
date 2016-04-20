### Swarm Master

* Get information about Docker Swarm: running and stopped containers and status of the nodes (healthy, unhealthy, pending, etc.) . We are using Overcommit on docker swarm 

    docker -H :4000 info
    
* Get information about containers (running and stopped) on Docker Swarm. **ps** will check all the nodes for containers. Verify if the nginx containers are running in each node.


    docker -H :4000 ps
    
    docker -H :4000 ps --all
    
* Get information about containers on the Swarm Master. Verify that the following containers are running: tuna, registry, swarm-manager and consul.

    docker ps
    
* Restart the docker daemon.

    service docker restart


** Consul (container)

* Check consul logs.

    docker logs consul
    
* Sometimes, after the docker daemon restarts consul get a different ip address. The following errors appear on consul:

    2016/04/14 14:51:44 [ERR] raft: Failed to make RequestVote RPC to 172.17.0.3:8300: dial tcp 172.17.0.3:8300: connection refused

  Verify the new ip address of consul
  
    docker inspect consul | grep IPAddress
  
  