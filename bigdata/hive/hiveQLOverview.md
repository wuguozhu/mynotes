# HiveQL 数据定义

hiveql不完全遵循 ANSI SQL，和MySQL方言最相似，hive增加了在Hadoop背景下可以提供更高性能的扩展，个性化扩展，以及增加一些外部程序。

## hive数据库

数据库本质上是一个目录或者命名空间。

 hive数据库创建后，比如 mydb, 那么会在hdfs目录的 /user/hive/warehouse/mydb.db创建这个目录。

即数据库的文件目录名是以 .db结尾的。

 默认情况下 hive不允许用户删除已个包含有表的数据库， 要么先删除库里面的表，要么删除库时使用cascade:  `hive>dorp database if exists mydb cascade;`



## hive 表

可以定义表存储位置   存储文件格式

hive默认创建的是管理表，这个表都会在默认 /user/hive/warehouse目录和子目录下。内部表不方便和其他工作共享数据。

hive会对内部表或多或少的控制数据的生命周期

```sql
create table stu1 as select * from stu;    /*这是创建表和增加数据*/
create table stu1 like  stu;               /*创建stu1结构和stu结构一样*/
 
```

## 分区表管理表

**a) 分区表中的严格模式存在意义:**

分区能将数据以一定符合逻辑的方式进行组织数据，比如分层存储。

在分区表中如果用户做一个查询，查询对象是所有员工，那么这个操作中hive会不得不扫描所有磁盘的数据，这种查询会触发一个巨大的mapreduce任务，一个高度的安全措施是将hive设置为strice严格模式，

这样如果对分区表进行查询而where没有加分区过滤的话，将会禁止提交这个任务，

```shell
hive> set hive.mapred.mode=strict;
hive> select * from employees e limit 10;
Error in semantic analysis: No partition predicate found for  ....
```

**b) 分区表使用例子**

日志文件分析:  记录有时间戳，严重程度(error warning info).服务器名称, 进程名，期望通过ETL，将每条日志信息转换为按照制表符分割的记录，将时间戳解析成年，月，日三个字段，剩余时间作为一个字段。

hive记录编码是通过 inputformat对象来控制，比如textfile对应的textinputformat的Java类，记录的解析是由序列化/反序列化 SerDe控制，为了保证完整性，hive还使用outputformat对象将数据写出出去。

上面的话总结： hive使用一个inputformat对象将输入流分割成记录，使用outputformat对象将记录格式化成输出流，使用SerDe在读数据时将一行行的记录解析成列，在写数据时将列组织成一行行记录。下例是hive自定义 serde  inputformat  outputformat写法：

```sql
create  mytable
partitioned by (ds string)
row format serde 'com.linkedin.haivvreo.AvroSerDe'
stored as
inputformat 'com.linkedin.haivvreo.AvroContainerInputFormat'
outputformat  'com.linkedin.haivvreo.AvroContainerOutputFormat';
```

## 修改表

alter table语句会修改元数据，但不会修改数据本身，这种修改需要用户确认所有的修改都和真实的数据是一致的。

## 其他

### 表保护

Hive提供了各种保护。下面的语句可以分别防止分区被删除和被查询：

```sql
/*防止误删*/
ALTER TABLE log_messages PARTITION(year = 2012, month = 1, day = 1) ENABLE NO_DROP;
/*禁止查询*/
ALTER TABLE log_messages PARTITION(year = 2012, month = 1, day = 1) ENABLE OFFLINE;
```



### 数据打包

`ALTER TABLE … ARCHIVE PARTITION`语句会将这个分区内的文件打成一个Hadoop压缩包（HAR）文件。但是这样仅仅可以降低文件系统中的文件数以及减轻NameNode的压力，而不会减少任何的存储空间（例如，通过压缩）：

```sql
ALTER TABLE log_messages ARCHIVE PARTITION(year = 2012, month = 1, day = 1);
```

