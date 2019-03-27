# CDH5.7.0 installs

## CDH简介

### CDH和Cloudera Manager支持的操作系统

| 操作系统          | 建议版本                                  | 备注 |
| ----------------- | ----------------------------------------- | ---- |
| RHEL / CentOS     | 6.8，6.9，7.2及以上                       |      |
| Oracle Linux (OL) | 5.7，5.11，7.2                            |      |
| SLES              | 11 SP4                                    |      |
| Ubuntu            | 14.04 LTS (Trusty)或者12.04 LTS (Precise) |      |
| Debian            | **7.8**, 7.1, 7.0 (Wheezy)                |      |

### 硬件要求

要评估群集的硬件和资源分配，我们需要分析要在群集上运行的工作负载类型，以及将用于运行这些工作负载的CDH组件。另外还应该考虑要存储和处理的数据大小，工作负载的频率，需要运行的并发作业的数量以及应用程序所需的速度。

在创建群集的体系结构时，我们需要在群集中的主机之间分配Cloudera Manager和CDH角色，以最大限度地利用资源。Cloudera提供了有关如何将角色分配给群集主机的一些指导。请参阅[推荐的群集主机和角色分配](https://www.cloudera.com/documentation/enterprise/release-notes/topics/cm_ig_host_allocations.html)。将多个角色分配给主机时，请将主机上每个角色的总资源要求（内存，CPU，磁盘）加在一起，以确定所需的硬件。

