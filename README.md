### TestLab

##### 1. Build docker with ansible based on Centos7
Create a [Dockerfile](https://github.com/Weizhang2017/TestLab/blob/master/Dockerfile) and build the image

```shell
docker build . -t localhost:5000/centos-ansible
```

##### 2. Start docker registry in the docker container
Run a container from registry image

```shell
docker run -d -p 5000:5000 --restart=always --name registry registry:2
```

##### 3. Push the docker image to the docker registry
Push the image into the registry
```shell
docker push localhost:5000/centos-ansible
```

##### 4. Deploy Nginx in front of the docker registry and add auth in it
Configure Nginx as reverse proxy server for the Docker registry: [docker-registry.conf](https://github.com/Weizhang2017/TestLab/blob/master/docker-registry.conf)
Create a password file for the docker registry

```shell
docker run --rm --entrypoint htpasswd registry:2.7.0 -bn <username> <password> auth/nginx.htpasswd
```


##### 5. Log in to the docker registry and pull the docker image
If the web server does not enable SSL certificate, an insecure registry is required to add to daemon.json, e.g.

```
 "insecure-registries": ["zhangwei.space:80"]
```

```shell
docker login -u=<username> -p=<password> zhangwei.space:80
docker pull zhangwei.space:80/centos-ansible

```