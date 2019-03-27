# Hadoop集群硬件规划

当我们想要去搭建一个Hadoop集群时，首要的任务是要考虑为这个新搭建的集群硬件进行规划，那么规划跟什么有关呢？依据又是什么，下面我们来一起看一下集群规划的方法论，如果不想看可以直接跳到"为CDH集群选择硬件"章节。

**存储与计算结合**

在搭建一个集群的时候我们是否首先应该考虑下，我们搭建的这个集群到底用来干嘛的，计算？存储？还是其他，你在搭建集群的时候有真正考虑过你的集群将要有多少工作负载吗？如果这方面考虑和调研清楚了，那么后面就是选合适的硬件配置就可以了。

**为什么跟工作负载有关系**

几乎在所有情况下，MapReduce作业都会遇到从磁盘或网络读取数据的瓶颈（称为IO绑定作业）或处理数据（CPU绑定）。IO绑定作业的一个示例是排序，这需要非常少的处理（简单比较）和大量读取和写入磁盘。CPU绑定作业的一个示例是分类，其中一些输入数据以非常复杂的方式处理以确定本体。

以下是几个IO绑定工作负载的示例：

- 索引
- 分组
- 数据导入和导出
- 数据移动和转换

以下是几个CPU绑定工作负载的示例：

- 聚类/分类
- 复杂的文本挖掘
- 自然语言处理
- 特征提取

由于Cloudera的客户需要彻底了解他们的工作负载以便全面优化Hadoop硬件，因此会出现经典的鸡与蛋问题。大多数希望构建Hadoop集群的团队还不知道他们的工作负载的最终配置文件，并且组织与Hadoop一起运行的第一个工作通常与Hadoop最终用于提高熟练程度的工作大不相同。此外，某些工作负载可能会以不可预见的方式受到约束。例如，由于用户选择压缩，某些理论上IO绑定的工作负载实际上可能受CPU约束，或者算法的不同实现可能会改变MapReduce作业的约束方式。

下一步是对平衡集群上运行的MapReduce作业进行基准测试，以分析它们的绑定方式。为了实现这一目标，通过实施全面的监控，可以直接测量实时工作负载并确定瓶颈。我们建议在Hadoop集群上安装Cloudera Manager，以提供有关CPU，磁盘和网络负载的实时统计信息。（Cloudera Manager是Cloudera Standard和Cloudera Enterprise的一个包含组件 - 在后一种情况下具有企业功能，例如支持滚动升级。）安装了Cloudera Manager后，Hadoop管理员可以运行他们的MapReduce作业并检查Cloudera管理器仪表板，以查看每台计算机的性能。  

第一步是了解您的运营团队已经管理的硬件。

为什么要去了解我们运营团队管理的硬件呢？现在国际贸易战那么热闹，你懂的^_^。除了构建适合工作负载的集群外，最好能与硬件供应商合作，以了解电源和散热的经济性。由于Hadoop运行在数十，数百或数千个节点上，因此运营团队可以通过投资节能硬件来节省大量资金。每个硬件供应商都能够提供有关如何监控电源和散热的工具和建议。

### 为CDH集群选择硬件

Hadoop集群中最基本会有这四种类型的角色：*NameNode*（和Standby NameNode），ResourceManager，NodeManager和DataNode。集群中的绝大多数机器同时是NodeManager（节点资源管理）和DataNode（数据存储）。

#### 基本推荐配置

**1.Hadoop集群DataNode和NodeManager节点推荐配置**

- 硬盘建议：12-24个1-4TB硬盘，JBOD（Just a Bunch Of Disks）
- CPU建议：2个四核/六核/八核CPU，主频至少2-2.5GHz
- 内存建议：64-512GB的内存
- 网卡建议：千兆或者万兆网卡（存储[数据流/量]越大，网络吞吐量要求越高）

**2.NameNode、ResourceManager和Standby NameNode节点推荐配置**

NameNode角色负责协调集群上的数据存储，ResourceManager负责协调数据处理。

- 1.建议运行NameNode和ResourceManager节点的主机，具有冗余电源和企业RAID 1或10配置中的级别磁盘。

- 2.Standby NameNode应该和NameNode部署在不同机器上，并且NameNode和Standby NameNode部署的主机硬件配置应该是一样的。

- 3.NameNode还需要RAM与集群中的数据块数量成正比。一个好的经验法则是为分布式文件系统中存储的每100万个块假设1GB的NameNode内存。在群集中有100个DataNode，NameNode上的64GB RAM为群集的扩展提供了充足的空间。

- 建议NameNode和ResourceManager都配置HA，这样会大大提高集群的高可用。

根据以上的推荐和建议NameNode、ResourceManager和Standby NameNode节点推荐配置

- JBOD配置中的4-6个1TB硬盘（1个用于操作系统，2个用于FS映像[RAID 1]，1个用于Apache ZooKeeper，1个用于Journal节点）
- 2个四核/六核/八核CPU，运行至少2-2.5GHz
- 64-128GB的RAM
- 保税千兆以太网或10千兆以太网

