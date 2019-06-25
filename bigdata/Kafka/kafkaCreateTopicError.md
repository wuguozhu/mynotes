# 创建TOPIC报"KeeperErrorCode = NoNode for /brokers/ids"异常

创建kafka topic时，报以下错误

```shell
[root@quickstart kafka_2.10-0.9.0.1]# kafka-topics.sh --create --topic test --zookeeper 192.168.200.128:2181 --partitions 3 --replication-factor 1
Error while executing topic command : org.apache.zookeeper.KeeperException$NoNodeException: KeeperErrorCode = NoNode for /brokers/ids
[2019-06-26 00:00:45,686] ERROR org.I0Itec.zkclient.exception.ZkNoNodeException: org.apache.zookeeper.KeeperException$NoNodeException: KeeperErrorCode = NoNode for /brokers/ids
        at org.I0Itec.zkclient.exception.ZkException.create(ZkException.java:47)

```

解决方案：

原因是我的`config/server.properties`的`zookeeper.connect`内容是这样子的

```
...
zookeeper.connect=192.168.200.128:2181/kafka
...
```

但是我创建时没有指定到kafka注册在zookeeper上对应的路径下所以会报错，后面我用下面的命令就创建成功了

```shell
[root@quickstart kafka_2.10-0.9.0.1]# kafka-topics.sh --create --topic test --zookeeper 192.168.200.128:2181/kafka --partitions 3 --replication-factor 1
Created topic "test".
[root@quickstart kafka_2.10-0.9.0.1]#
```

完毕，