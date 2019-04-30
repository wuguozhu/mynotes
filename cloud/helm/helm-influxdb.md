## 获取influxdb chart

搜索influxdb chart

```
[root@hadoop1]~/k8s/helm/mysql# helm search influx
NAME                    CHART VERSION   APP VERSION     DESCRIPTION
stable/influxdb         1.1.3           1.7.3           Scalable datastore for metrics, events, and real-time ana...
stable/kapacitor        1.1.1           1.5.2           InfluxDB's native data processing engine. It can process ...
stable/telegraf         0.3.3           1.5             Telegraf is an agent written in Go for collecting, proces...
```

拉取influxdb chart

```
[root@hadoop1]~/k8s/helm/mysql# helm fetch stable/influxdb --version 1.1.3 --untar
```

