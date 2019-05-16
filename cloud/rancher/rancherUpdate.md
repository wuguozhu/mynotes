## Rancher 升级

```shell
# rancher 升级官网指引
# https://rancher.com/docs/rancher/v2.x/en/upgrades/upgrades/single-node-upgrade/
# 开始升级 
# 1.备份数据
docker run  --volumes-from rancher-data -v $PWD:/backup alpine tar zcvf /backup/rancher-data-backup-<RANCHER_VERSION>-<DATE>.tar.gz /var/lib/rancher
e.g:
docker run  --volumes-from rancher-data -v $PWD:/backup alpine tar zcvf /backup/rancher-data-backup-v2.1.7-20190515.tar.gz /var/lib/rancher

# 2.停止rancher server
docker stop <RANCHER_CONTAINER_NAME>
e.g：
docker stop 304b229f11f2

# 3.创建数据容器
docker create --volumes-from <RANCHER_CONTAINER_NAME> --name rancher-data rancher/rancher:<RANCHER_CONTAINER_TAG>
e.g:
docker create --volumes-from 304b229f11f2 --name rancher-data rancher/rancher:stable

# 4.如果在升级过程中出现问题
docker run --volumes-from rancher-data -v $PWD:/backup alpine tar zcvf /backup/rancher-data-backup-<RANCHER_VERSION>-<DATE>.tar.gz /var/lib/rancher
e.g:
docker run --volumes-from rancher-data -v $PWD:/backup alpine tar zcvf /backup/rancher-data-backup-v2.1.7-20190515.tar.gz /var/lib/rancher

# 5.查看备份tar包
[rancher@ip-10-0-0-50 ~]$ ls
rancher-data-backup-v2.1.7-20190515.tar.gz

# 6.将备份tarball移动到Rancher Server外部的安全位置。

# 7.拉镜像
docker pull rancher/rancher:stable

# 8.使用容器中的数据启动新的Rancher Server rancher-data容器。
# 从备份文件升级
docker run -d --volumes-from rancher-data --restart=unless-stopped -p 80:80 -p 443:443 rancher/rancher:stable

# 将元数据备份到宿主机并升级
docker run -d --volumes-from rancher-data --restart=unless-stopped -p 80:80 -p 443:443 -v /data/docker/volumes:/var/lib/rancher/rancher rancher/rancher:stable
```

