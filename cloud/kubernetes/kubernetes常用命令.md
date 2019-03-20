## Kubernetes 常用命令

创建deployment

```shell
[root@hadoop1]~/k8s# kubectl apply -f nginx.yaml
deployment.extensions/nginx-deployment created
[root@hadoop1]~/k8s#
```

查看deployment

```shell
[root@hadoop1]~/k8s# kubectl get  deployment
NAME               DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
nginx-app          1         1         1            1           13h
nginx-deployment   2         2         2            2           32m
[root@hadoop1]~/k8s#
```

删除deployment

```shell
[root@hadoop1]~/k8s# kubectl delete deployment nginx-app
deployment.extensions "nginx-app" deleted
[root@hadoop1]~/k8s#
```

伸缩:将nginx.yaml文件中的replica的值修改，然后重新执行`kubectl apply`

```shell
[root@hadoop1]~/k8s# kubectl apply -f nginx.yaml
deployment.extensions/nginx-deployment configured
[root@hadoop1]~/k8s#
```

获取replica

```shell
[root@hadoop1]~/k8s# kubectl get rs
NAME                          DESIRED   CURRENT   READY   AGE
nginx-deployment-74d6569489   3         3         3       2h
[root@hadoop1]~/k8s#
```

获取Pod的信息

```shell
[root@hadoop1]~/k8s# kubectl get pod
NAME                                READY   STATUS    RESTARTS   AGE
nginx-deployment-74d6569489-g8htf   1/1     Running   0          2h
nginx-deployment-74d6569489-tvj8x   1/1     Running   0          1h
nginx-deployment-74d6569489-zsbxl   1/1     Running   0          2h
[root@hadoop1]~/k8s# kubectl get pod -o wide
NAME                                READY   STATUS    RESTARTS   AGE   IP           NODE      NOMINATED NODE
nginx-deployment-74d6569489-g8htf   1/1     Running   0          2h    10.42.0.9    hadoop1   <none>
nginx-deployment-74d6569489-tvj8x   1/1     Running   0          1h    10.42.0.10   hadoop1   <none>
nginx-deployment-74d6569489-zsbxl   1/1     Running   0          2h    10.42.0.8    hadoop1   <none>
[root@hadoop1]~/k8s#
```

在线更新

将nginx镜像从1.7.1更新至1.9.1

```shell
## kubectl set image deployment/nginx-deployment nginx=nginx:1.9.1
[root@hadoop1]~/k8s# kubectl describe deployment nginx-deployment
Name:                   nginx-deployment
Namespace:              default
CreationTimestamp:      Sat, 16 Feb 2019 15:30:48 +0800
Labels:                 app=web-server
Annotations:            deployment.kubernetes.io/revision: 1
                        kubectl.kubernetes.io/last-applied-configuration:
                         ...
Pod Template:
  Labels:  app=web-server
  Containers:
   nginx:
    Image:        nginx:1.7.9
    ...
NewReplicaSet:   nginx-deployment-74d6569489 (3/3 replicas created)
Events:          <none>
[root@hadoop1]~/k8s# kubectl set image deployment/nginx-deployment nginx=nginx:1.9.1
deployment.extensions/nginx-deployment image updated
[root@hadoop1]~/k8s# kubectl describe deployment nginx-deployment
Name:                   nginx-deployment
Namespace:              default
CreationTimestamp:      Sat, 16 Feb 2019 15:30:48 +0800
Labels:                 app=web-server
Annotations:            deployment.kubernetes.io/revision: 2
                        kubectl.kubernetes.io/last-applied-configuration:
                        ...
Pod Template:
  Labels:  app=web-server
  Containers:
   nginx:
    Image:        nginx:1.9.1
    ...
[root@hadoop1]~/k8s#

```

