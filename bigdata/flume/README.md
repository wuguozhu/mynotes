​	Flume是Cloudera提供的一个高可用的，高可靠的，分布式的海量日志采集、聚合和传输的系统，Flume支持在日志系统中定制各类数据发送方，用于收集数据；同时，Flume提供对数据进行简单处理，并写到各种数据接受方（可定制）的能力。[来源：百度百科](https://baike.baidu.com/item/flume/6250098?fr=aladdin)

​	Flume算是我刚开始工作时候的吃饭技能了，现在虽然不经常用了但是算下来用Flume也有差不多三年时间了；中间遇到了各种各样的问题也都一一熬过来了，时间过得真快啊。开这么个space是希望把近年来使用Flume的一些案例和心得记录下来，算是对自己的总结吧，如果有幸能帮助到其他也在用Flume的同行那就更好了，废话就说那么多，下面上开胃菜。

[Flume官方文档：](http://flume.apache.org/documentation.html)英文文档，小伙伴们别对英文恐惧哇，里面都是比较浅显易懂的。

- `Flume User Guide`            为最新Release版本用户指南

- `Flume Devloper Guide`    为最新Release版本开发者指南

Flume的原理和架构我在这里就不写了，那么点东西，自己Google啦。大数据生态常用的Flume的Source，Channel和Sink如下：
**[Flume Sources](http://flume.apache.org/releases/content/1.9.0/FlumeUserGuide.html#flume-sources)**
[Spooling Directory Source](http://flume.apache.org/releases/content/1.9.0/FlumeUserGuide.html#spooling-directory-source)  文件目录源
[Taildir Source](http://flume.apache.org/releases/content/1.9.0/FlumeUserGuide.html#taildir-source)                        文件源
[Kafka Source](http://flume.apache.org/releases/content/1.9.0/FlumeUserGuide.html#kafka-source)                         Kafka源

**[Flume Channels](http://flume.apache.org/releases/content/1.9.0/FlumeUserGuide.html#flume-channels)**
[Memory Channel](http://flume.apache.org/releases/content/1.9.0/FlumeUserGuide.html#memory-channel)                 内存管道
[JDBC Channel](http://flume.apache.org/releases/content/1.9.0/FlumeUserGuide.html#jdbc-channel)                       JDBC管道
[Kafka Channel](http://flume.apache.org/releases/content/1.9.0/FlumeUserGuide.html#kafka-channel)                      Kafka管道
[File Channel](http://flume.apache.org/releases/content/1.9.0/FlumeUserGuide.html#file-channel)                          文件管道

**[Flume Sinks](http://flume.apache.org/releases/content/1.9.0/FlumeUserGuide.html#flume-sinks)**
[HDFS Sink](http://flume.apache.org/releases/content/1.9.0/FlumeUserGuide.html#hdfs-sink)                              写入HDFS
[Hive Sink](http://flume.apache.org/releases/content/1.9.0/FlumeUserGuide.html#hive-sink)                                写入Hive
[Null Sink](http://flume.apache.org/releases/content/1.9.0/FlumeUserGuide.html#null-sink)                                 写入空(相当于删掉)
[HBaseSinks](http://flume.apache.org/releases/content/1.9.0/FlumeUserGuide.html#hbasesinks)                            写入Hbase
[Kafka Sink](http://flume.apache.org/releases/content/1.9.0/FlumeUserGuide.html#kafka-sink)                              写入Kafka

> 以上针对1.9.0版本的flume(没办法啊，链接被写死了|_|)

硬菜来啦，欢迎讨论，邮箱在首页^_^

[Flume监控本地目录写入HDFS]()

[Flume监控本地目录写入Kafka]()

[Flume监控本地目录写入Hive]()

[Flume拉取Kafka数据写入HDFS]()

[Flume拉取Kafka数据写入Kafka]()

[Flume拉取Kafka数据写入Hive]()

[Flume拉取Kafka数据双写Kafka]()

[Flume拉取Kafka数据双写HDFS]()

[Flume拉取Kafka数据双写Hive]()





