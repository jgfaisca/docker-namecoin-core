# docker-namecoind-core
Automated dockerhub build for namecoin-core, a reimplementation of Namecoin on top of the current Bitcoin Core codebase. 

### NETWORK
$ ./create-docker-network.sh 

### IMAGE
$ ./build_local.sh 

### RUN
$ ./run-namecoin-docker.sh nmc-node 10.17.0.2

### LOG
$ docker logs -f nmc-node  

### TEST
#### Namecoin version
$ docker exec -it 'nmc-node' namecoin-cli -version
#### Get general information from the node
$ docker exec -it 'nmc-node' namecoin-cli -datadir=/data/namecoin -getinfo

### CONSOLE
$ docker exec -it 'nmc-node' bash
