# 从备份恢复NameNode服务

## 前言

**文档目的**

话说“月有阴晴圆缺，人有朝夕祸福”何况物呢？趟在机房的服务器说不准哪天一不小心就遭雷击了，着火了或者不小心被机房运维人员踢了一脚冒烟了。为了规避这些意外，运维狗们是想尽了办法，今天我（本人目前的职位为Hadoop实施运维工程师）也突发奇想，NameNode服务器遭遇物理损坏了怎么办？为什么这么想呢？因为我要出一个服务器搬迁的方案，正好要搬迁的服务器有NameNode节点的服务器，所以以防万一点子臭搬搬迁过程中NameNode服务器坏了那就出大事了，因此今天先在测试环境模拟一把，大致的思想是向集群加入一条新主机从相关的备份数据恢复NameNode服务。



**内容概述**

1.新增一台服务器，做好前置条件

2.在NameNode节点把该备份的备份好__^_^__（什么叫该备份的），然后复制到新节点

3.关掉原来NameNode节点服务器，把新加入的节点的iP和主机名改为原来的NameNode节点ip和主机名

4.





**测试环境**

1.CM和CDH版本为5.16.1

2.采用root用户操作

3.操作系统Redhat7.2

**前置条件**

1.集群已启用Kerberos



## 前置条件

1.hostname及hosts配置

2.禁用SELinux

3.关闭防火墙

4.集群时钟同步

5.设置swap交换分区

6.设置透明大页面

以上具体步骤略过，如果不会请

## 备份NameNode元数据


