## kafka 常用命令

```shell
1.查看当前Kafka集群中Topic的情况
命令：
bin/kafka-topics.sh --list --zookeeper127.0.0.1:2181
ps:列出该zookeeper中记录在案的topic列表，只有名字

2.查看Topic的分区和副本情况
命令：
bin/kafka-topics.sh --describe --zookeeper 127.0.0.1:2181  --topic test0
运行结果：
Topic:test      PartitionCount:1        ReplicationFactor:1     Configs:
Topic: test     Partition: 0    Leader: 313     Replicas: 313   Isr: 313
结果分析：
第一行显示partitions的概况，列出了Topic名字，partition总数，存储这些partition的broker数

以下每一行都是其中一个partition的详细信息：
leader 
是该partitons所在的所有broker中担任leader的broker id，每个broker都有可能成为leader
replicas 
显示该partiton所有副本所在的broker列表，包括leader，不管该broker是否是存活，不管是否和leader保持了同步。
isr 
in-sync replicas的简写，表示存活且副本都已同步的的broker集合，是replicas的子集
举例：
比如上面结果的第一行：Topic: test0  Partition:0    Leader: 0       Replicas: 0,2,1 Isr: 1,0,2
Partition: 0
该partition编号是0
Replicas: 0,2,1
代表partition0 在broker0，broker1，broker2上保存了副本

Isr: 1,0,2

代表broker0，broker1，broker2都存活而且目前都和leader保持同步

Leader: 0

代表保存在broker0，broker1，broker2上的这三个副本中，leader是broker0

leader负责读写，broker1、broker2负责从broker0同步信息，平时没他俩什么事

当producer发送一个消息时，producer自己会判断发送到哪个partiton上，如果发到了partition0上，消息会发到leader，也就是broker0上，broker0处理这个消息，broker1、broker2从broker0同步这个消息

如果这个broker0挂了，那么kafka会在Isr列表里剩下的broker1、broker2中选一个新的leader

 

3创建Topic
命令：
bin/kafka-topics.sh --create --topic test_wu --zookeeper 127.0.0.1:2181 --config max.message.bytes=12800000 --config flush.messages=1 --partitions 5 --replication-factor 1
说明：
--topic后面的test0是topic的名称
--zookeeper应该和server.properties文件中的zookeeper.connect一样
--config指定当前topic上有效的参数值
--partitions指定topic的partition数量，如果不指定该数量，默认是server.properties文件中的num.partitions配置值
--replication-factor指定每个partition的副本个数，默认1个

 

4.删除topic
比如删除test0这个topic
1，删除kafka的topic
命令：
bin/kafka-topics.sh --delete --zookeeper 127.0.0.1:2181 --topic test0
如果server.properties中没有把delete.topic.enable设为true，那么此时的删除并不是真正的删除，而是把topic标记为：marked for deletion
2，删除kafka中该topic相关的目录。
在server.properties中找到配置log.dirs，把该目录下test0相关的目录删掉
3，登录zookeeper client。
命令：
/home/ZooKeeper/bin/zkCli.sh
4，删除zookeeper中该topic相关的目录
命令：
rm -r /kafka/config/topics/test0
rm -r /kafka/brokers/topics/test0
rm -r /kafka/admin/delete_topics/test0 （topic被标记为marked for deletion时需要这个命令）
5，重启zookeeper和broker

 

5.查看topic消费到的offset
命令：
bin/kafka-run-class.sh kafka.tools.GetOffsetShell --broker-list 127.0.0.1:9092 --topic test0 --time -1
运行结果：
test0:0:177496
test0:1:61414

 

6.查看topic各个分区的消息的信息
命令：
bin/kafka-run-class.sh kafka.tools.ConsumerOffsetChecker --group testgroup --topic test0 --zookeeper 127.0.0.1:2181
运行结果：
GROUP     TOPIC      PID                 OFFSET         LOGSIZE   LAG
消费者组   topic名字  partition id    当前已消费的条数       总条数     未消费的条数

 

7.修改topic的partition数量（只能增加不能减少）
命令：
bin/kafka-topics.sh --alter --zookeeper 127.0.0.1:2183 --partitions 10 --topic test0

8.修改topic的副本数
1，自己写一个文件addReplicas.json，文件的内容是JSON格式的，比如：

{

   "version": 1,

   "partitions": [

       {

           "topic": "test0",

           "partition": 0,

           "replicas": [

                1,2

           ]

       },

       {

           "topic": "test0",

           "partition": 1,

           "replicas": [

                1,2,3

           ]

       },

       {

           "topic": "test0",

           "partition": 2,

           "replicas": [

                1,2,3

           ]

       }

    ]

}

2，运行命令：
bin/kafka-reassign-partitions.sh --zookeeper 127.0.0.1:9092 --reassignment-json-file addReplicas.json --execute

 

9.kafka服务启动
命令：
bin/kafka-server-start.sh -daemon config/server.properties 

10.下线broker
比如下线broker0
命令：
bin/kafka-run-class.sh kafka.admin.ShutdownBroker --zookeeper 127.0.0.1:2181 --broker 0 --num.retries 3 --retry.interval.ms 60
shutdown broker
如果需要迁移，需要其他额外的操作。

11.设置保留时间
# Deprecated way
bin/kafka-topics.sh  --zookeeper localhost:2181 --alter --topic test_topic --config retention.ms=1000
# Modern way
bin/kafka-configs.sh --zookeeper localhost:2181 --alter --entity-type topics --entity-name test_topic --add-config retention.ms=1000


12.生产数据
bin/kafka-console-producer.sh --broker-list localhost:9092 --topic test < file-input.txt

13.消费数据
bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic test --from-beginning --partition 0
参考：
https://blog.csdn.net/isea533/article/details/73720066
https://blog.csdn.net/lkforce/article/details/77776684

```

