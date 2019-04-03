```sh
docker命令大全：https://www.cnblogs.com/panwenbin-logs/p/8001410.html

#查看镜像
docker images

#查看正在运行的镜像
docker ps

#进入容器
docker exec -it cdh /bin/bash

#删除镜像
docker rmi iname
docker rmi -f iname --强制删除

#删除容器
docker rm container
docker rm -f container --强制删除

#保存状态
docker commit -a "Author" -m "Commit message" oldname newname
e.g:
docker commit -a "Author" -m "Commit message" cdh cloudera/quickstart:latest

#启动/停止镜像
docker start/stop iname

#初始化镜像
docker run
e.g1:
docker run --privileged=true \
--name=cdh5.7 -v /hadoop/cdh5.7:/data \
--hostname=quickstart.cloudera -p 8020:8020 -t -i -d cdh5.7 /usr/bin/docker-quickstart  
imags:
[rongbojie@192 ~]$ sudo docker images
REPOSITORY                       TAG                 IMAGE ID            CREATED             SIZE
mysql                            5.7                 5709795eeffa        7 weeks ago         408MB
hello-world                      latest              725dcfab7d63        7 weeks ago         1.84kB
cloudera/quickstart              5.7.0               2c36606bfade        2 months ago        7GB
mdillon/postgis                  9.4                 d6b606b5c9f2        2 months ago        601MB

e.g2:
sudo docker run --privileged=true --name=cdh5.7 --hostname=quickstart.cloudera -p 7180:7180 -p 8020:8020 -p  8088:8088 -p  8888-8889:8888-8889 - 18088:18088 -p  19888:19888 -p  21050:21050 -p  50010:50010 -p  50020:50020 -p  50070:50070 -p  50075:50075 -t -i -d cloudera/quickstart:5.7.0 /usr/bin/docker-quickstart

#A very good Link:
http://blog.csdn.net/kunloz520/article/details/53839237

#搜索镜像
docker search iname

#导出镜像有两种方式
docker save -o fedora-latest.tar fedora:latest
docker export --output="latest.tar" red_panda

# 导入镜像 两种方式
docker load -i fedora-latest.tar
docker import /path/to/exampleimage.tgz
# 备注：
# 当用docker save 导出镜像时，用load导入镜像
# 当用docker export 导出镜像时，用import导入镜像
```

