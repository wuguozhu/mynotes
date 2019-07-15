# hive调优

[不要脸的转载：HIVE的十项企业级调优](http://www.zhongruitech.com/624015186.html)

[不要脸的转载：大数据：Hive常用参数调优](https://www.cnblogs.com/ITtangtang/p/7683028.html)

## Expalin方式

根据语法树，对hive SQL 进行调优，使其用最优方式执行任务。



## limit 方式

limit方式不用跑MapReduce,下面这两种方式不走MapReduce

```
select * from employees; //全表查询
select * from employees limit 2; //抽样查询
```

有三个参数与其相关：

一旦属性`hive.limit.optimize.enable`的值设置为`true`。

那么还会有两个参数可以控制这个操作

`hive.limit.row.max.size  //行大小`

`hive.limit.optimize.limit.file //文件大小`

这种方式的缺点：这是一种对数据进行抽样的方式，有可能有用的数据永远不会被处理到



## Join 操作

我们知道，如果join都在reduce端，其实非常消耗资源的，尤其是一个非常大的表和非常小的表join,比如B表有1亿行记录，A表只有1000行记录，那么会导致**严重数据倾斜**， 因此当有小表连接大表的时候 我们可以将小表放到内存中处理, **在map阶段进行join**, 即所谓的map join
语法很简单 只需要`/*+ MAPJOIN(b) */` 就可以把需要分发的表放到内存中

```sql
hive (default)> select /*+MAPJOIN(course)*/ c.id, c.course from
              > origin a join course c on (c.id = a.id);
```

- `set hive.auto.convert.join=true //开启自动map join（高版本已经自动开启了）`
- `set hive.mapjoin.smalltable.filesize //设置大表小表阈值（默认25M）`

另外：不过需要提醒自己要清楚哪个表是最大的，并将最大的表放置在join的最右边。



## 本地模式

```shell
set hive.exec.mode.local.auto=true（开启本地模式）
```

Hive 可以通过本地模式在单台机器上 处理所有的任务。对于小数据集，执行时间可以明显被缩短

①开启本地模式后需要设置local mr的最大输入数据量，当数据量小于这个值时采用local mr的方式

```
set hive.exec.mode.local.auto.inputbytes.max=134217728（默认）
```

②开启本地模式后需要设置local mr的最大输入文件个数，当数据量小于这个值时采用local mr的方式

```
set hive.exec.mode.local.auto.input.files.max=4（默认）
```

## 并行执行

Hive会将一个查询转化成一个或者多个阶段。这样的阶段可以是MapReduce阶段、抽样阶段、合并阶段、limit阶段，或者Hive执行过程中可能需要的其他阶段。默认情况下，Hive一次只会执行一个阶段。不过，某个特定的job可能包含众多的阶段，而这些阶段可能并非完全互相依赖的，也就是说有些阶段是可以并行执行的，这样可能使得整个job的执行时间缩短。不过，如果有更多的阶段可以并行执行，那么job可能就越快完成。

开启并行执行需要设置`hive.exec.parallel`为`true`

## 严格模式

Hive提供了一个严格模式，可以防止用户执行那些可能产生意想不到的不好的影响的查询。通过设置属性hive.mapred.mode值为strict可以禁止3种类型的查询。

- where条件必须含有分区字段作为限制，否则不允许查询

- 对于使用了ORDER BY 语句的查询，要求必须使用LIMIT语句。

  > ORDER BY为了执行排序过程会将所有的结果数据分发到同一个reducer中进行处理，强制要求用户增加这个LIMIT语句可以防止reducer额外执行很长一段时间

- 限制笛卡尔积的查询

## 调整mapper和reducer个数

小文件造成非常多数量的map任务就会导致启动阶段、调度和运行job过程中产生过多的开销；

- map个数一般由文件数来决定

- reduce个数默认为3个



## JVM重用

需要时间来理解~~



## 索引

索引可以加快由group by 语句的计算速度



## 表优化

TODO

