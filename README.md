## Deployment docker system for smartstorm services

#### Description

It is complete environment for build and run projects:

* [Storm API](https://github.com/smart-storm/storm-api)
* [Storm UI](https://github.com/smart-storm/storm-ui)
* [Storm Streaming](https://github.com/smart-storm/storm-streaming)
* [Storm Webiste](https://github.com/smart-storm/storm-website)

#### Requirements:

* [Docker](https://docs.docker.com/install/) 
* [Docker Composer](https://docs.docker.com/compose/install/)

#### Instalation

Change `KAFKA_ADVERTISED_HOST_NAME` in `docker-compose.yml` to your docker host ip.

To check that:

* Windows/Mac: `docker-machine ip` 
* Linux: `ifconfig -a`

#### Usage

Run `sudo docker-compose up -d` for complete instalation and start services

Run `sudo docker-compose build --no-cache` for complete rebuild containers

You can run single service by passing its name as parameter ex. 
```
sudo docker-compose build --no-cache streaming
``` 

To access running container shell run `sudo docker ps` to find container id, then `sudo docker exec -it *container_id* bash`

#### Web

##### Linux

To access services add these lines to /etc/hosts:

```/etc/hosts
127.0.0.1       app.smartstorm.io                                                                                                                                                                                                      
127.0.0.1       smartstorm.io 
```

##### Windows/Mac

Use equivalent solution in your system, remember to change `127.0.0.1` to docker host ip address


