# Overview
Elixir Ambience helps developers to quickly deliver comprehensive, safe and reliable software solutions. Developer can rapidly create applications with seamless integration to MongoDB for data management and support enterprise business reporting functions such as dashboards and reports out of the box.

For more infomation on Elixir Ambience, you may visit https://docs.elixirtech.com/Ambience/2023.0/index.html or www.elixirtech.com. A docker image of Elixir Ambience is at https://hub.docker.com/r/elixirtech/elixir-ambience.

# Run Ambience with Docker Compose

## Requirement
-  Unix OS as macOS or Linux - scripts use sh or bash unix shell. You will need to adapt the scripts to other operating system as Windows
- Docker engine with Compose, you can install the software from https://docs.docker.com/get-docker/
- Elixir Ambience trial licence is shipped with the image. You can obtain a full licence from sales@elixirtech.com and deploy via browser into the Ambience Database or  place in "etc" folder and enable the volume mapping in docker-compose.yaml to use a local licence in the folder. 

## Steps
- Run docker compose to start a Mongodb database and Ambience. 

```
./run-ambience-compose.sh 
```

This will pull a latest Ambience and MongoDB image at elixirtech/elixir-ambience docker repository, start Mongodb and Ambience services in the order as shown below. 

```
latest: Pulling from elixirtech/elixir-ambience
Digest: sha256:b6bfd3b320cedc18588e028ad65dd080b6f281725e78cde5d6aabe1cede4ec54
Status: Image is up to date for elixirtech/elixir-ambience:latest
docker.io/elixirtech/elixir-ambience:latest
[+] Running 2/2
 ⠿ Container elixir-mongo         Started
 ⠿ Container elixir-ambience  Started  
``` 

## Configuration
- Docker compose configuration file is docker-compose.yaml. It is configured to run a MongoDB database and Ambience containers. You can remove the MongoDB configuration if you have running MongoDB already in the host.

- Ambience configuration parameters for Ambience is in a hidden file ".env". The parameters as

```
mongourl="mongodb://mongo:27017"
externalhost="localhost"
externalport="1740"
externalprotocol="http:"
```

You can configure default mongodb url, external host, port and http protocol. 

##  Useful docker compose commands and scripts

Below is a list of commonly use docker command

- List the services as

```
docker compose ps
```

- To stop you can run 

```
docker compose stop
```

- To remove the containers 

```
docker compose rm
```

- To restart the containers 

```
docker compose restart
```

- To restart Ambience container

This useful if you deploy Ambience licence via the browser, you will need to restart Ambience container to apply the licence you can use

```
docker compose  restart elx-ambience
```


- debug a running Ambience container 

```
cd tools
./debug-compose.sh
```

- run ambience container without compose
Alternative you can run a standalone Ambience container without using compose

```
cd tools
./run-ambience.sh
```

## Security note

Mongo port is locked down to only access with the host i.e. localhost. 
