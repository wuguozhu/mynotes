1. 当前你们公司使用的Hadoop版本是什么

   > CDH 5.7 

2. HDFS常见的数据压缩格式有哪些，介绍其中一种详细的实现方式

3. HDFS垃圾回收的时间模式是多久，如何修改该时间

4. HDFS如何生效机架感知，取消机架感知有什么问题

5. HDFS常见的运维操作有哪些，哪些操作是高危的，如果高危操作出现问题，如何解决

6. HDFS常见的故障是什么，如何处理，是否可以给出三种预案来防范大部分常见故障

7. 你经历过哪些严重的Hadoop故障

8. HDFS常用的IO压力测试工具有哪些

9. Hadoop哪些地方依赖于主机名，是否可以全部替换为IP呢（HDFS/YARN/SPARK）

10. HDFS有哪些核心的指标需要采集和监控，最重要的三个指标是什么

11. HDFS节点下线，如何提升其下线速度

12. HDFS常见的误删除数据场景，以及如何防止数据被误删除

13. HDFS集群对外提供的访问方式有几种，哪种最为常见，每种方式各自的优缺点和使用场景

14. HDFS你做过哪些性能调优，哪些是通用的，哪些是针对特定场景的

15. Hadoop日常的运维操作有什么管理工具，已经搭建的集群如何使用ambari

16. Hadoop各类角色如何进行扩容，缩容，节点迁移（IP变更）

17. Hadoop各类角色的JVM参数配置如何设定

18. HDFS的block大小如何设置，取决于哪些因素

19. YARN的nodemanager上跑任务的时候，有时候会将磁盘全部打满，如何解决

20. HDFS集群多个业务方使用时如何提前做好运维规划，如权限，配额，流量突增，数据安全，目录结构

21. [HDFS中，小文件的定义是什么，如何对小文件进行统计分析，如何优化该问题](http://dongxicheng.org/mapreduce/hdfs-small-files-solution/)

22. HDFS的namenode如何进行主备切换

23. YARN的nodemanager导致机器死机，如何解决

24. 如何下线YARN的nodemanager节点，假如该节点持续在运行计算任务

25. YARN的nodemanager节点，从Active Nodes转为Lost Nodes，有哪些原因，在哪里设置

26. YARN的nodemanager节点如果转为Lost Nodes后，该节点上的计算任务是否还会正常继续

27. HDFS的快照原理简要介绍一下，为什么可以确保数据的安全性

28. YARN的yarn.nodemanager.local-dirs和yarn.nodemanager.log-dirs参数应该如何设置，有哪些常见的问题

29. distcp拷贝数据的时候，出现了java.lang.outofmemoryerror:java heap space，如何处理

30. 有两个hadoop集群，机器相同，磁盘占用相同，一个集群磁盘的使用率比较均匀，另一个集群磁盘使用率起伏较大（很多写满的，很多使用率很低的），那么第二个集群会有哪些问题

31. hdfs namenode启动慢，常见的原因有哪些？如何优化？

32. hadoop的hdfs、yarn配置的zookeeper，是否可以分开