# 面试题范围整理：
## 1.HBase常用命令（创建表、删除表、禁用表等操作），写HBase的方式可以通过shell命令，HBase API等方式
----

**创建表**

```shell
create ‘<table name>’,’<column family>’ 
e.g:
create 'emp' ,'id','name','infomation'
```

**列出表**

```sehll
list
```

**禁用表**

```shell
disable 'emp'
is_disabled 'emp' # 验证
```

**扫描表**

```shell
scan 'emp'
```

**启用表**

```shell
enable 'emp'
is_enabled 'emp' # 验证
```

**表存在**

```shell
exists 'emp'
```

**删除表**

```shell
# hbase 删除表需要先把它禁用(下线)
disable 'emp'     # 禁用
is_enabled 'emp'  # 验证
drop 'emp'        # 删除
drop_all 'emp.*'  # 支持正则批量删除
```

**Hbase API**

```java
public void put(String tableName,String rowKey,String family,String column,String value)
	{
		Configuration conf=init();
		try {
			HTable table=new HTable(conf,TableName.valueOf(tableName));
			HBaseAdmin admin=new HBaseAdmin(conf);
			//判断表是否存在，如果不存在进行创建
			if(!admin.tableExists(Bytes.toBytes(tableName)))
			{
				HTableDescriptor tableDescriptor=new HTableDescriptor(Bytes.toBytes(tableName));
				HColumnDescriptor columnDescriptor=new HColumnDescriptor(Bytes.toBytes(family));
				tableDescriptor.addFamily(columnDescriptor);
				admin.createTable(tableDescriptor);
			}
			table.setAutoFlush(true);
			//进行数据插入
			Put put=new Put(Bytes.toBytes(rowKey));
			put.add(Bytes.toBytes(family),Bytes.toBytes(column),Bytes.toBytes(value));
			table.put(put);
			table.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
```



## 2.HBase都有哪些角色，角色使用来干嘛的？

Hbase采用Master/slave架构搭建集群，它隶属于Hadoop生态系统，有以下类型节点组成：HMaster节点、HRegionServer节点、zookeeper集群，而底层数据存储于HDFS中，

![img](http://www.blogjava.net/images/blogjava_net/dlevin/HBaseArch1.jpg)

其中**HMaster节点**用于：

1.管理HRegionServer，实现其负载均衡

2.管理和分配HRegion，比如在HRegion split时分配新的HRegion；在HRegionServer退出时迁移其内的HRegion到其他HRegionServer上。

3.实现DDL操作（Data Definition Language，namespace和table的增删改，column familiy的增删改等）。

4.管理namespace和table的元数据（实际存储在HDFS上）

5.权限控制（ACL）

**HRegionServer节点**用于：

1.存放和管理本地的HRegion

2.读写HDFS，管理Table中的数据

3.Client直接通过HRegionServer读写数据

**ZooKeeper集群是协调系统**，用于：

1. 存放整个 HBase集群的元数据以及集群的状态信息。
2. 实现HMaster主从节点的failover。

原理：[深入HBase架构解析](http://www.blogjava.net/DLevin/archive/2015/08/22/426877.html)



## 3.Kerberos集群扩容数据节点及客户节点（配置CDH集群外客户端节点）

[如何给Kerberos环境下的CDH集群添加Gateway节点](https://cloud.tencent.com/developer/article/1078433)

总结：

跟非Kerberos差不多，唯一区别是需要先在该节点上部署Kerberos客户端节点并把集群Kerberos的`krb5.conf`文件同步到该节点再进行节点添加。

## 4.Spark写HBase优化（写入慢问题处理）

**优化**

```shell
1.禁止Major Compaction
# 在hbase进行Major Compaction时，该region将合并所有的storefile，因此整个region都不可读，所有对此region的查询都会block。
# 该操作可以在系统空闲时执行，使用crontab在晚上执行这个动作
2.禁掉split
# hbase通过split region实现水平的sharding，但在split的过程中旧的region会下线，新region还会做compaction，中间有一段时间大量的数据不能被读写
# 该操作可以在系统空闲时执行，使用crontab在晚上执行这个动作
3.设置blockingStoreFiles
# 在flushRegion时会检测当前store中hfile的数量是否大于此值，如果大于则会block数据的写入，等待其他线程将hfile compact掉。

参考：https://zhangxiong0301.iteye.com/blog/2220540
```

## 5.如何做集群角色划分（合理规划集群角色）

[CDH网络要求(Lenovo参考架构)](https://mp.weixin.qq.com/s?__biz=MzI4OTY3MTUyNg==&mid=2247483653&idx=1&sn=f2f35bf9ac30e5e61fc5c569f53a9dab&chksm=ec2ad10cdb5d581a7355ba7056ed4b3e30f9bd1bc5412532cfe690f3c9a42000418e8afd4dba&scene=21#wechat_redirect)

[如何为Hadoop集群选择正确的硬件](https://mp.weixin.qq.com/s?__biz=MzI4OTY3MTUyNg==&mid=2247485329&idx=1&sn=7d4fb9f9ea3f1fb08d2aaa0a808f9302&chksm=ec2ad798db5d5e8e67859afbffa977ff86db86a0e667840dbf0bb9dfc89262dd4ee4fee0a06b&scene=21#wechat_redirect)

[如何给Hadoop集群划分角色](https://mp.weixin.qq.com/s?__biz=MzI4OTY3MTUyNg==&mid=2247487209&idx=1&sn=a9d7b1cba01526fe1b1fb7a085dd9e9c&chksm=ec2adee0db5d57f687ef5be19077dfc2f94428950c7b95865f62d790bd46363ee6e039341702&scene=21#wechat_redirect)



## 6.Hadoop集群中租户和用户的是什

```
多租户可以比做多个人租用一套房，每个人占一个独立卧室；
对应到hadoop的话就对应资源池，某个资源池下可以提交多个用户
```





## 7.Yarn资源池配置(最大最小资源池配置、Yarn ACL访问权限)





# 广发常用到的集群组件：HDFS、Hive、HBase、Spark、CDSW、Yarn
## 1.HDFS主要是配额目录权限问题，集群资源使用情况统计（CM的集群利用率），集群小文件统计分析（Navigator服务有），针对这些问题如何解决？

### HDFS额配

```shell
# 设置文件数配额
hdfs dfsadmin -setQuota <N> <directory>...<directory>   # 文件数额配
hdfs dfsadmin -clrQuota <directory>...<directory>		# 清除额配
# 设置目录下的文件总数为1000个
hdfs dfsadmin -setQuota 1000 /p/work

# 设置空间额配
hdfs dfsadmin -setSpaceQuota <N> <directory>...<directory>
hdfs dfsadmin -clrSpaceQuota <directory>...<director>
# 设置目录大小为9T,算上副本，也就是存3T的数据
hdfs dfsadmin -setSpaceQuota 9T /p/work
```

### 集群资源使用情况统计

```
可以通过CM开启YARN的资源利用率报告实现
```

### 集群小文件统计分析

```
navigation可以做到这一点
```

## 2.Hive常用的建表（内部表、外部表），权限管理等，针对目前多个业务部门、如何划分权限？如何结合HDFS配额限制租户对集群存储的使用？防止租户写入大量数据导致HDFS空间不足。

```shell
1.在sentry端限制用户的(增删查改)
2.针对数据写入可以用目录额配限制用户无限写入数据
```

## 3.HBase目前经常会出现一些性能问题（主要是SPark大型作业写HBase导致HBase整体性能下降），如何解决Spark写入HBase慢的问题？（批量入库的方式、BulkLoad方式等）根据业务场景不同是否有自己的一些见解。

```shell
针对以上问题可以从以下四个方面去分析
1.系统资源是否充足
2.Hbase 优化
	#1.禁止Major Compaction
	#2.禁用split
	#3.调整blockingStoreFiles 数量

3.程序代码的优化
# 频繁调用client对Hbase读写是一种性能比较低的行为，但是考虑到实时的场景。
# 如题，针对大型作业对Hbase写入的话一般只存在于离线计算，这种场景是长时间计算一次写入,这样如果再调用client去一条一条插入的话，是不太实用的，
这种场景我们应该考虑批量写入，hbase批量写入有两种方式
# 1.批量插入:put(List<Put> list)
# 2.缓存块插入：先把数据写到client内存，然后在一次性刷新到Hbase中
# 3.实用BulkLoad方式生产Hfile文件，直接load进Hbase对应表的目录中

#优化参考：https://blog.csdn.net/u011518678/article/details/50790193
#BulkLoad 参考：https://segmentfault.com/a/1190000009762041
```

TODO： Hbase rowkey设计





4.CDSW主要是用户经常提出的写入权限问题，Spark指定Python环境问题，如何定制镜像？

```

```

