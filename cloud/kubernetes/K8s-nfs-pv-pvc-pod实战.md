## Kubernetes test Pv and PVC with NFS
### 安装NFS
#### 1.查看系统是否已安装NFS
```shell
[root@hadoop1]~/k8s# rpm -qa | grep nfs
[root@hadoop1]~/k8s# rpm -qa | grep rpcbind
[root@hadoop1]~/k8s#
```
### 2.安装NFS
```shell
[root@hadoop1]~/k8s# yum -y install nfs-utils rpcbind
...
complete !
```
### 3.服务端配置
```shell
[root@hadoop1]~/k8s# mkdir -p /data/nfs
[root@hadoop1]~/k8s# ll /data/
总用量 4
drwxr-xr-x. 2 root root 4096 10月 21 18:10 nfs
[root@hadoop1]~/k8s# chmod 666 /data/nfs/
```
编辑export文件
```shell
[root@hadoop1 ~]# vim /etc/exports 
/data/nfs 192.168.6.0/24(rw,no_root_squash,no_all_squash,sync)
```
> `192.168.6.0/24`表示192.168.6 这个网段都可以访问到这个文件系统来

生效配置
```shell
[root@hadoop1 nfs]# exportfs -r
```

###  4.启动NFS
```shell
# 启动rpcbind
[root@hadoop1 nfs]# systemctl start rpcbind
# 查看状态
[root@hadoop1 nfs]# systemctl status rpcbind
# 开机自启
[root@hadoop1 nfs]# systemctl enable rpcbind

## 先等rpcbind 再启动 nfs
# 启动nfs
[root@hadoop1 nfs]# systemctl start nfs
# 查看状态
[root@hadoop1 nfs]# systemctl status nfs
# 开机自启
[root@hadoop1 nfs]# systemctl enable nfs
```
验证
```
[root@hadoop1]~/k8s# showmount -e
Export list for hadoop1.richstone.com:
/data/nfs 192.168.6.0/24
[root@hadoop1]~/k8s#
```

### 5.客户端配置
如果客户端与kubernetes集群不在一个节点上，需要安装客户端
```shell
[root@hadoop1 nfs]# yum -y install nfs-utils
```
创建挂载目录
```shell
[root@hadoop1]~/k8s# mkdir /k8spv
```
查看服务器抛出的共享目录信息
```shell
[root@hadoop1]~/k8s# showmount -e 192.168.6.219
Export list for 192.168.6.219:
/data/nfs 192.168.6.0/24
[root@hadoop1]~/k8s#
```
为了提高NFS的稳定性，使用TCP协议挂载，NFS默认用UDP协议
```shell
[root@hadoop1]~/k8s# mount -t nfs 192.168.6.219:/data/nfs /k8spv -o proto=tcp -o nolock
[root@hadoop1]~/k8s#
```
验证
```shell
[root@hadoop1]~# df -h
Filesystem               Size  Used Avail Use% Mounted on
/dev/sda2                 40G   33G  4.7G  88% /
devtmpfs                 9.8G     0  9.8G   0% /dev
tmpfs                    9.8G  4.0K  9.8G   1% /dev/shm
tmpfs                    9.8G  738M  9.1G   8% /run
tmpfs                    9.8G     0  9.8G   0% /sys/fs/cgroup
/dev/sda1                180M  172M     0 100% /boot
/dev/sdb1                 99G   35G   59G  37% /data
192.168.6.219:/data/nfs   99G   35G   59G  37% /k8spv
tmpfs                    2.0G     0  2.0G   0% /run/user/0
[root@hadoop1]~/k8s#
```
### 6.创建PV、PVC、Pod

```yaml
[root@hadoop1]~/k8s# cat mypv.yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: mypv
spec:
  capacity:
    storage: 1Gi
  volumeMode: Filesystem
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Recycle
  storageClassName: nfs
  mountOptions:
    - hard
    - nfsvers=4.1
  nfs:
    path: /data/nfs
    server: 192.168.6.219
```
创建PVC
```yaml
[root@hadoop1]~/k8s# cat mypvc.yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: mypvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
  storageClassName: nfs
```
创建Pod
```yaml
[root@hadoop1]~/k8s# cat mypvtest.yaml
apiVersion: v1
kind: Pod
metadata:
  name: mypvtest
spec:
  containers:
    - name: mypvtest
      image: busybox
      args:
        - /bin/sh
        - -c
        - sleep 30000
      volumeMounts:
        - mountPath: "/mydata"
          name: mydata
  volumes:
    - name: mydata
      persistentVolumeClaim:
        claimName: mypvc
[root@hadoop1]~/k8s#
```
执行创建命令
```shell
[root@hadoop1]~/k8s# kubectl apply -f mypv.yaml
persistentvolume/mypv created
[root@hadoop1]~/k8s# kubectl apply -f mypvc.yaml
persistentvolumeclaim/mypvc created
[root@hadoop1]~/k8s# kubectl apply -f mypvtest.yaml
pod/mypvtest created
[root@hadoop1]~/k8s#
```
原理参考：[这里](https://www.cnblogs.com/CloudMan6/p/8721078.html)
验证
```shell
[root@hadoop1]~/k8s# kubectl get pod
NAME                                READY   STATUS    RESTARTS   AGE
...
mypvtest                            1/1     Running   0          50m
...
[root@hadoop1]~/k8s#
```
如果STATUS一直处于ContainerCreating那就是有问题的可以用命令`kubectl describe pod mypvtest`查看问题
到此我们已经从安装NFS到测试PV、PVC再到关联Pod测试完成，如果有幸能帮助到您，希望能给个赞，谢谢^_^

感谢以下原创：
[每天5分钟玩转Kubernetes](https://www.cnblogs.com/CloudMan6/tag/Kubernetes/)