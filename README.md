# docker-namecoind-core
Automated dockerhub build for namecoin-core, a reimplementation of Namecoin on top of the current Bitcoin Core codebase. 

### RUN
$ ./create-docker-network.sh <br>
$ ./build_local.sh <br>
$ ./run-namecoin-docker.sh nmc-node 10.17.0.2<br>

### LOG
$ docker logs -f nmc-node  

### TEST
$ docker exec -it 'nmc-node' 

### SHELL CONSOLE
$ docker exec -it 'nmc-node' bash
