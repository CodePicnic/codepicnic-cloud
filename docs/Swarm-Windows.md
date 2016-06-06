## Requirements

Install Windows Server 2016 TP5 . Available [in Azure](https://azure.microsoft.com/en-us/marketplace/partners/microsoft/windowsservertechnicalpreview/)

External access to port 2375 must be enabled through Azure security groups.

## Install Docker Engine

Execute all commands below using PowerShell

* Install Container Feature

    Install-WindowsFeature containers

* Install Docker (daemon and client)

    New-Item -Type Directory -Path 'C:\Program Files\docker\'
    Invoke-WebRequest https://aka.ms/tp5/b/dockerd -OutFile $env:ProgramFiles\docker\dockerd.exe
    Invoke-WebRequest https://aka.ms/tp5/b/docker -OutFile $env:ProgramFiles\docker\docker.exe
    [Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\Program Files\Docker", [EnvironmentVariableTarget]::Machine)
    
* Install Docker as a Service

    dockerd --register-service

* Install Container Images (windowsservercore)

    Install-PackageProvider ContainerImage -Force
    Install-ContainerImage -Name WindowsServerCore
    Restart-Service docker
    docker tag windowsservercore:10.0.14300.1000 windowsservercore:latest

## Connect to Swarm

* Add the following parameters when run Docker daemon as a service and restart

    docker-daemon --label os=windows -H 0.0.0.0:2375
    
* Build the Swarm for Windows images from [codepicnic-dockerfiles](https://github.com/CodePicnic/codepicnic-dockerfiles/swarm-windows)    

* Run swarm with the following parameters (assuming we are connecting to CodeGround Swarm)

    docker -H :2375 run -it swarm join --advertise 40.121.62.33:2375 consul://54.210.2.20:8500
    
    40.121.62.33 -> Windows Server
    54.210.2.20 -> Swarm Server
    
* Check in the swarm server if the node is connected:

    docker -H :4000 info

  az-swarm-01: 40.121.62.33:2375
  └ Status: Healthy
  └ Containers: 18
  └ Reserved CPUs: 0 / 10001
  └ Reserved Memory: 0 B / 34.18 TiB
  └ Labels: executiondriver=, kernelversion=10.0 14300 (14300.1016.amd64fre.rs1_release_svc.160428-1819), operatingsystem=Windows Server 2016 Datacenter Technical Preview 5, storagedriver=Windows filter storage driver
  └ Error: (none)
  └ UpdatedAt: 2016-06-06T20:52:32Z
  └ ServerVersion: 1.12.0-dev




