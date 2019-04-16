## Uninstall CDH 5.x

导读：本文操作环境为CDH离线安装环境下

### 关闭CM应用

略，

### 停止Server和Client服务

在CM安装节点上执行以下命令：

```shell
[root@hadoop1 ~]# /opt/cm-5.13.0/etc/init.d/cloudera-scm-server  stop
cloudera-scm-server is already stopped
[root@hadoop1 ~]#
```

在集群所有节点执行以下命令：

```shell
[root@hadoop1 ~]# /opt/cm-5.13.0/etc/init.d/cloudera-scm-agent  stop
cloudera-scm-agent is already stopped
[root@hadoop1 ~]#
```

### 杀进程

在每个节点执行以下命令

> 注意：以下命令为强制杀cloudera

```shell
[root@hadoop1]~# ps -ef | grep cloudera | grep -v grep | cut -b10-15 | xargs kill -9
[root@hadoop1]~# ps -ef | grep supervisord | grep -v grep | cut -b10-15 | xargs kill -9
[root@hadoop1]~#
```

### Umount cm_processes挂载

在CM安装节点上执行以下命令

```shell
[root@hadoop1]~# umount /opt/cm-5.13.0/run/cloudera-scm-server/process
[root@hadoop1]~# 
```

在集群所有节点执行以下命令

```shell
[root@hadoop1]~# umount /opt/cm-5.13.0/run/cloudera-scm-agent/process
[root@hadoop1]~# 
```

### 删除数据目录

删除Cloudera Manager数据 、数据库存放路径、Cloudera Manager Lock 文件、用户数据、清除安装文件 （安装方式不一样，可能配置文件路径不一样，删除时候注意，小心删错别的文件，安装的服务不一样，可能涉及到的文件路径有差别，以下是默认路径）

```shell
/opt
/var/lib
/var/log
/etc
/etc/alternatives
/bin
/usr/bin/
/tmp
/usr/share
/var/cache/yum/x86_64/7
```

先在上面目录中找出CDH相关的目录及文件再将命令保存到类似如下的脚本里，执行后将删除命令分发到各个节点去执行删除操作(`重要的事说三遍：谨慎操作，谨慎操作，谨慎操作;`)

```shell
#!/bin/bash

for i in {7..10};
do
   ssh 10.10.1.$i "rm -rf rm -rf /var/lib/flume-ng /var/lib/hadoop* /var/lib/hue /var/lib/navigator /var/lib/oozie /var/lib/solr /var/lib/sqoop* /var/lib/zookeeper;"
done
```





本文参考了以下文章:

[卸载CDH5.14.2](https://blog.csdn.net/qq_30982323/article/details/80988154)

[CDH5.X完全卸载步骤](https://blog.csdn.net/wulantian/article/details/42706777)

感谢以上原创作者

删除列表

```shell
rm -rf /etc/alternatives/bigtop-detect-javahome
rm -rf /etc/alternatives/catalogd
rm -rf /etc/alternatives/cli_mt
rm -rf /etc/alternatives/cli_st
rm -rf /etc/alternatives/hadoop*
rm -rf /etc/alternatives/hbase*
rm -rf /etc/alternatives/hue-conf*
rm -rf /etc/alternatives/kafka*
rm -rf /etc/alternatives/kite-dataset
rm -rf /etc/alternatives/load_gen
rm -rf /etc/alternatives/sqoop*
rm -rf /etc/alternatives/statestored
rm -rf /etc/alternatives/avro-tools
rm -rf /etc/alternatives/beeline
rm -rf /etc/alternatives/cdsw
rm -rf /etc/alternatives/docker
rm -rf /etc/alternatives/dockerd
rm -rf /etc/alternatives/flume-*
rm -rf /etc/alternatives/hcat
rm -rf /etc/alternatives/hdfs
rm -rf /etc/alternatives/hive* 
rm -rf /etc/alternatives/impala*
rm -rf /etc/alternatives/kube*
rm -rf /etc/alternatives/kudu
rm -rf /etc/alternatives/llama*
rm -rf /etc/alternatives/mahout*
rm -rf /etc/alternatives/mapred
rm -rf /etc/alternatives/oozie
rm -rf /etc/alternatives/parquet-tools
rm -rf /etc/alternatives/pig*
rm -rf /etc/alternatives/pyspark
rm -rf /etc/alternatives/sentry*
rm -rf /etc/alternatives/solr*
rm -rf /etc/alternatives/spark*
rm -rf /etc/alternatives/whirr
rm -rf /etc/alternatives/yarn
rm -rf /etc/alternatives/zookeeper*
rm -rf /var/log/flume-ng
rm -rf /var/log/hadoop-*
rm -rf /var/log/hive
rm -rf /var/log/impala*
rm -rf /var/log/kafka
rm -rf /var/log/spark*
rm -rf /var/log/zookeeper
rm -rf /var/log/hcatalog
rm -rf /etc/flume*
rm -rf /etc/kafka*
rm -rf /etc/spark*
rm -rf /etc/solr*
rm -rf /etc/hbase
rm -rf /etc/hive*
rm -rf /etc/hue
rm -rf /etc/impala
rm -rf /etc/kafka
rm -rf /etc/solr
rm -rf /etc/spark
rm -rf /etc/sqoop*
rm -rf /etc/zookeeper
rm -rf /etc/cdsw
rm -rf /etc/sentry
rm -rf /etc/hadoop
rm -rf /etc/hbase*
rm -rf /etc/pig
rm -rf /bin/avro*
rm -rf /bin/beeline
rm -rf /bin/bigtop-detect-javahome
rm -rf /bin/catalogd
rm -rf /bin/cli_mt
rm -rf /bin/flume-ng
rm -rf /bin/hadoop*
rm -rf /bin/hbase*
rm -rf /bin/hcat
rm -rf /bin/impala*
rm -rf /bin/kafka*
rm -rf /bin/kite-dataset
rm -rf /bin/llama
rm -rf /bin/mahout
rm -rf /bin/parquet-tools
rm -rf /bin/pig
rm -rf /bin/pyspark*
rm -rf /bin/sentry
rm -rf /bin/solrctl
rm -rf /bin/spark
rm -rf /bin/statestored
rm -rf /bin/whirr
rm -rf /bin/zookeeper
rm -rf /bin/cli_st
rm -rf /bin/hdfs*
rm -rf /bin/hive*
rm -rf /bin/kudu
rm -rf /bin/llamaadmin
rm -rf /bin/mapred
rm -rf /bin/oozie
rm -rf /bin/spark-*
rm -rf /bin/sqoop*
rm -rf /bin/yarn
rm -rf /usr/bin/zookeeper-*
rm -rf /var/lib/flume-ng
rm -rf /var/lib/hadoop-*
rm -rf /var/lib/impala
rm -rf /var/lib/kudu
rm -rf /var/lib/zookeeper
rm -rf /data/dfs/* /data/impala
```

