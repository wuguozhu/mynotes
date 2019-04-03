# docker服务宿主机可以访问外网无法访问

**问题描述：**

`192.168.8.115`为docker服务所在的宿主机

```sh
tomcat@hw-hadoop1-> telnet 192.168.8.115 3000
Trying 192.168.8.115...
Connected to 192.168.8.115.
Escape character is '^]'.
^[^A^[^A^[^A^[^A^[^A^[^AConnection closed by foreign host.
tomcat@hw-hadoop1->
```

从上面我们可以看出宿主机是可以访问的

```sh
[root@hadoop3 ~]# telnet 192.168.8.115 3000
Trying 192.168.8.115...
^C
[root@hadoop3 ~]# telnet 192.168.8.115 8085
Trying 192.168.8.115...
Connected to 192.168.8.115.
Escape character is '^]'.
^CConnection closed by foreign host.
[root@hadoop3 ~]# ifconfig
eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1450
        inet 10.0.0.12  netmask 255.255.255.0  broadcast 10.0.0.255
        ...
```

从上述中我们可以看到`10.0.0.12 hadoop3`的`8085`端口可以访问，`3000`端口不能访问。

到这里问题基本已经可以定位出来了，是**`防火墙`**的问题。

然后我就开始google`如何开放防火墙端口`搜出来的博客大多是这样子的

```sh
iptables -A INPUT -ptcp --dport  3000 -j ACCEPT
serivce iptables save
```

然后在远程机器上再`telnet`一次但是不行，原因不明|_|

**解决方案：**

第一个方案不行，让我有了干掉防火墙的想法。但是就这么干掉的话好像会出问题，那么我就想到只干掉docker那部分的行不行，说干就干--重建docker防火墙规则。

```sh
# 安装brctl 
apt-get install bridge-utils
yum install bridge-utils
# 停止docker服务
systemctl stop docker
# 重建 docker 网络
ifconfig docker0 down
brctl delbr docker0
# 重启docker服务
systemctl start docker
```

再测一次，已经可以了

```sh
[root@hadoop3 ~]# telnet 192.168.8.115 3000
Trying 192.168.8.115...
Connected to 192.168.8.115.
Escape character is '^]'.
```

有思路就有方向



