# 数据质量监控系统

本模块包含目前为止包含两个收集组件

1. `telegraf: 1.9.0`

2. `jmxtrans: 270`

本模块将集成influxdb和grafana使用

## Telegraf 组件简介
Telegraf是收集、处理、聚合和编写度量的代理。

设计目标是尽量减少插件系统的内存占用，这样社区中的开发人员就可以轻松地添加对收集指标的支持。

Telegraf是插件驱动的，有4种不同的插件类型:

1. 输入插件从系统、服务或第三方api收集指标

2. 处理器插件转换、修饰和/或过滤指标

3. 聚合器插件创建聚合度量(例如平均值、最小值、最大值、分位数等)。

4. 输出插件将指标写入不同的目标

目前该插件实现了以下功能：
标准输出数据监控
MySQL数据监控
PostgresSQL数据监控
英伟达GPU监控
主机硬件指标监控


> [TIG(telegraf,influxdb,grafana)使用方式](./telegraf/)

> [Telegraf 官网](https://github.com/influxdata/telegraf)

## Jmxtrans 组件简介

jmxtrans是一个工具，它允许您连接到任意数量的Java虚拟机(jvm)并查询它们的属性，而无需编写任何一行Java代码。属性通过Java管理扩展(JMX)从JVM导出。大多数Java应用程序都通过这个协议提供了它们的统计信息，>并且可以将其添加到任何代码基中，而不需要做很多工作。如果您对代码使用SpringFramework，那么只需向Java类文件中添加一些注释即可


目前该插件实现了以下功能：

kafka指标监控

> [JIG(Jmxtrans,influxdb,grafana)使用方式](./jmxtrans/)

> [Jmxtrans 官网](https://github.com/jmxtrans/jmxtrans)

