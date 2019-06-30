[Spark处理百亿规模数据优化实战](https://blog.csdn.net/aijiudu/article/details/75206590)

[手把手教你 Spark 性能调优](https://my.oschina.net/leejun2005/blog/1157245)

Spark 任务提交

```shell
#
./bin/spark-submit \
  --[your class] \
  --master yarn \
  --deploy-mode cluster \
  --num-executors 17 \
  --conf spark.yarn.executor.memoryOverhead=4096 \
  --executor-memory 35G \
  --conf spark.yarn.driver.memoryOverhead=4096 \
  --driver-memory 35G \
  --executor-cores 5 \
  --driver-cores 5 \
  --conf spark.default.parallelism=170 \
  /path/to/examples.jar
  
#   
./start-thriftserver.sh \
--master yarn-client \
--conf spark.driver.memory=3G \
--conf spark.shuffle.service.enabled=true \
--conf spark.dynamicAllocation.enabled=true \
--conf spark.dynamicAllocation.minExecutors=1 \
--conf spark.dynamicAllocation.maxExecutors=30 \
--conf spark.dynamicAllocation.sustainedSchedulerBacklogTimeout=5s

# run example wordcount
spark-submit --class org.apache.spark.examples.JavaWordCount --master yarn --num-executors 5 --executor-memory 1G  --executor-cores 1  --driver-cores 1 --driver-memory 1G  --conf "spark.yarn.executor.memoryOverhead=1024" --conf "spark.yarn.driver.memoryOverhead=1024" --conf "spark.dynamicAllocation.enabled=true" --conf "spark.dynamicAllocation.maxExecutors=30" /opt/cloudera/parcels/CDH/jars/spark-examples-1.6.0-cdh5.16.1-hadoop2.6.0-cdh5.16.1.jar /user/wuguozhu
```

