# Helm安装

## 安装kubectl

helm可以部署在任何机器上，不一定要在kubernetes的服务器上,但是需要安装kubectl，也就是说用户家目录下要有kube的配置文件，因为helm需要和apiServer通信。

在rancher宿主机上使用kubectl命令访问rancher集群，可以参考我的这篇文章[如何宿主机上操作Rancher2部署的K8S集群](https://www.jianshu.com/p/14d6da403598)

## 开始部署

```sh
[root@hadoop1]~# wget https://storage.googleapis.com/kubernetes-helm/helm-v2.12.1-linux-amd64.tar.gz
[root@hadoop1]/opt# mv helm-v2.12.1-linux-amd64.tar.gz /opt
[root@hadoop1]/opt# tar -zxvf helm-v2.12.1-linux-amd64.tar.gz
[root@hadoop1]/opt# mv linux-amd64 helm
[root@hadoop1]/opt# cd helm
[root@hadoop1]/opt/helm# mv helm /usr/bin
[root@hadoop1]/opt/helm# ll /usr/bin/helm
-rwxr-xr-x 1 root root 36844864 Dec 20 07:09 /usr/bin/helm
[root@hadoop1]/opt/helm#
```

因某些原因我们无法直接从google下载tiller镜像，所以需要下载这个哥们的[网盘共享](https://pan.baidu.com/s/13Hm4DymwW4E95RgjQj-h5Q)的镜像`tiller-image-v2.12.1.tar.gz`，然后在每个node节点加载镜像

加载镜像到本地仓库：

```sh
[root@hadoop1]/opt/helm# docker load < tiller-image-v2.12.1.tar.gz
7f6225146918: Loading layer [==================================================>]  6.006MB/6.006MB
539ca8e1be01: Loading layer [==================================================>]  36.85MB/36.85MB
d152ff069955: Loading layer [==================================================>]   36.5MB/36.5MB
Loaded image: gcr.io/kubernetes-helm/tiller:v2.12.1
[root@hadoop1]/opt/helm#
```

编辑tiller服务文件`rbac-config.yaml`

```yaml
[root@hadoop1]/opt/helm# cat rbac-config.yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: tiller
  namespace: kube-system
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: tiller
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
  - kind: ServiceAccount
    name: tiller
    namespace: kube-system
[root@hadoop1]/opt/helm#
```

创建

```sh
[root@hadoop1]/opt/helm# kubectl create -f rbac-config.yaml
serviceaccount/tiller created
clusterrolebinding.rbac.authorization.k8s.io/tiller created
[root@hadoop1]/opt/helm# helm init --service-account tiller
Creating /root/.helm
Creating /root/.helm/repository
Creating /root/.helm/repository/cache
Creating /root/.helm/repository/local
Creating /root/.helm/plugins
Creating /root/.helm/starters
Creating /root/.helm/cache/archive
Creating /root/.helm/repository/repositories.yaml
Adding stable repo with URL: https://kubernetes-charts.storage.googleapis.com
Adding local repo with URL: http://127.0.0.1:8879/charts 
$HELM_HOME has been configured at /root/.helm.

Tiller (the Helm server-side component) has been installed into your Kubernetes Cluster.

Please note: by default, Tiller is deployed with an insecure 'allow unauthenticated users' policy.
To prevent this, run `helm init` with the --tiller-tls-verify flag.
For more information on securing your installation see: https://docs.helm.sh/using_helm/#securing-your-helm-installation
Happy Helming!

[root@node-01 helm]#
```

如果在访问`https://kubernetes-charts.storage.googleapis.com`的时候发生`time out`可以尝试将`nameserver 114.114.114.114`追加到`/etc/resolv.conf`中再试。

**验证**

```sh
[root@hadoop1]/opt/helm# kubectl -n kube-system get pod | grep tiller
tiller-deploy-8485766469-sc2kp            1/1     Running     0          3m37s
[root@hadoop1]/opt/helm# helm version
Client: &version.Version{SemVer:"v2.12.1", GitCommit:"02a47c7249b1fc6d8fd3b94e6b4babf9d818144e", GitTreeState:"clean"}
Server: &version.Version{SemVer:"v2.12.1", GitCommit:"02a47c7249b1fc6d8fd3b94e6b4babf9d818144e", GitTreeState:"clean"}
[root@hadoop1]/opt/helm#
```

到此，我们已经实现了在Rancher环境下安装了helm。

如果本文有幸能帮助到您，是否能奖赏个`start`呢？ 不胜感激，谢谢！



