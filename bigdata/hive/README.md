  本系列文章为阅读《Hive编程指南》的时候我认为有必要做下笔记的部分或重新组织或摘抄等方式记录下来的，权当深刻记忆。

- **1.Hive与数据仓库**
  - [1-1 Hive在Hadoop Ecosystem中的地位]()
  - [1-2 Hive的版本演进与目前现状]()
  - [1-3 课程实践环境说明]()
  - [1-4 实操: Hive/Hadoop预备环境安装]()
- **2.Hive的基本概念**

  - [2-1 Hive的安装部署]()
  - [2-2 Hive的基本架构]()
  - [2-3 启动Hive]()
  - [2-4 Hive命令行]()
  - [2-5 HiveServer与JDBC/ODBC]()
  - [2-6 实操: Hive命令行和ThriftServer基本使用]()
- **3.数据类型与文件格式**

  - [数据类型](hivedatatype.md)
  - [数据存储与文件格式](hivedatastorage.md)
- **4.HiveQL：数据定义**
  - []()
- **5.HiveQL：数据操作**
  - [5-1 加载数据（LoadData）]()
  - [5-2 从查询计算结果加载数据(Insert Table Select)]()
  - [5-3 动态分区(DynamicPartitioning)]()
  - [5-4 CTAS（CreateTableAsSelect）]()
  - [5-5 导出数据]()
  - [5-6 实操: 练习以上数据加载计算和导出操作]()
- **6.HiveQL：数据查询**
  - [6-1 从最简单的开始]()
  - [6-2 Select … From]()
  - [6-3 Where条件]()
  - [6-4 Group By条件]()
  - [6-5 Join]()
  - [6-6 排序（OrderBy/SortBy）]()
  - [6-7 ClusterBy/DistributeBy]()
  - [6-8 抽样（Sampling）]()
  - [6-9 Union]()
  - [6-10 实操: 练习以上各种查询语法]()
- **7.Hive函数与自定义函数**
  - [7-1 查看与调用函数]()
  - [7-2 常用标准函数（UDF）]()
  - [7-3 UDAF]()
  - [7-4 UDTF]()
  - [7-5 UDF/UDAF/UDTF开发]()
- **8.Hive常用模式设计**
  - [8-1 按天做Partition]()
  - [8-2 分桶（Bucket）]()
  - [8-3 压缩]()
  - [8-4 表Schema变更]()
- **9.Hive调优**
  - [Hive调优](hiveoptimizer.md)
- **10.Hive新特性与其他**
  - [10-1 Hive on Tez]()

  - [10-2 Hive on Spark]()

  - [10-3 Hive与HBase集成]()

  - [10-4 HCatalog]()


### hive权限控制 //TODO