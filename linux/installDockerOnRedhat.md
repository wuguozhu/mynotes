# 在RedHat7.2上安装最新版Docker

**写在前面**

这段时间想把kubernetes捡起来，那么最基本是把环境先装起来吧，说干就干，装k8s要先装docker咯，网上安装docker的博客万千千万，按理说随便捡一篇就装起来了呀？说出来你可能不信，我用的Google搜索搜出来的博客试了一遍，硬是没有一篇文章能使我安装成功的，因为我的是Redhat的操作系统，很多依赖没法搞定，一怒之下看官网文档，果然官方文档靠谱，窃喜之余，顺便记录一下，如果有幸能帮助到他人那就更好了~

**实践环境**

```shell
LSB Version:    :core-4.1-amd64:core-4.1-noarch
Distributor ID: RedHatEnterpriseServer
Description:    Red Hat Enterprise Linux Server release 7.2 (Maipo)
Release:        7.2
Codename:       Maipo
```

**OS要求**

要安装Docker Engine - Community，您需要CentOS 7的维护版本。不支持或测试存档版本。该`centos-extras`库必须启用。默认情况下，此存储库已启用，但如果已将其禁用，则需要 [重新启用它](https://wiki.centos.org/AdditionalResources/Repositories)。`overlay2`建议使用存储驱动程序。

**卸载旧版本**

较旧版本的Docker被称为`docker`或`docker-engine`。如果已安装这些，请卸载它们以及相关的依赖项。

```
$ sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine
```

如果`yum`报告没有安装这些软件包，则可以。

`/var/lib/docker/`保存包括镜像，容器，volume和网络等内容。

**安装方式**

- 大多数用户 [设置Docker的存储库](https://docs.docker.com/install/linux/docker-ce/centos/#install-using-the-repository)并从中进行安装，以便于安装和升级任务。这是推荐的方法。
- 有些用户下载RPM软件包并 [手动安装](https://docs.docker.com/install/linux/docker-ce/centos/#install-from-a-package)并完全手动管理升级。这在诸如在没有访问互联网的气隙系统上安装Docker的情况下非常有用。
- 在测试和开发环境中，一些用户选择使用自动 [便捷脚本](https://docs.docker.com/install/linux/docker-ce/centos/#install-using-the-convenience-script)来安装Docker。

安装方式用以上三种，这里我用的是yum方式，所以我要下载和配置yum的`repo`

**配置yum源**

安装所需的包。`yum-utils`提供了`yum-config-manager` 效用，并`device-mapper-persistent-data`和`lvm2`由需要 `devicemapper`存储驱动程序。

```shell
[root@hadoop2 ~]# sudo yum install -y yum-utils device-mapper-persistent-data lvm2
```

配置`repo`

```shell
[root@hadoop2 ~]# sudo yum-config-manager  --add-repo https://download.docker.com/linux/centos/docker-ce.repo
```

**安装docker**

安装最新版本的docker-ec

```
[root@hadoop2 ~]# sudo yum install docker-ce docker-ce-cli containerd.io
```

安装指定版本的docker

先用以下命令查询yum源中有哪些版本的docker可用

```
 yum list docker-ce --showduplicates | sort -r
```

再安装，例如我要安装一个`docker-ce-18.09.1`

```shell
#sudo yum install docker-ce-<VERSION_STRING> docker-ce-cli-<VERSION_STRING> containerd.io
e.g:
[root@hadoop2 ~]# sudo yum install docker-ce-docker-ce-18.09.1 docker-ce-cli-docker-ce-18.09.1 containerd.io
```

**启动及使用**

```shell
# 启动docker
[root@hadoop2 ~]# sudo systemctl start docker 
# 设置开机启动
[root@hadoop2 ~]# sudo systemctl enable docker
# 查看启动状态
[root@hadoop2 ~]# sudo systemctl status docker
```

下面还有两种安装方法自行查看吧，本文其实来自下面链接的翻译：https://docs.docker.com/install/linux/docker-ce/centos/

