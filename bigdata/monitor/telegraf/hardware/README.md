# 主机性能指标监控

编辑修改Telegraf 配置文件:`/etc/telegraf/telegraf.conf`

```
# congif to net
[[inputs.net]]
interfaces = ["eth0"]
ignore_protocol_stats = false

# config to netstat
[[inputs.netstat]]

# Get kernel statistics from /proc/stat
[[inputs.kernel]]
  # no configuration


# Read metrics about memory usage
[[inputs.mem]]
  # no configuration


# Get the number of processes and group them by status
[[inputs.processes]]
  # no configuration


# Read metrics about swap memory usage
[[inputs.swap]]
  # no configuration


# Read metrics about system load & uptime
[[inputs.system]]
  # no configuration

[[inputs.cpu]]
  ## Whether to report per-cpu stats or not
  percpu = true
  ## Whether to report total system cpu stats or not
  totalcpu = true
  ## If true, collect raw CPU time metrics.
  collect_cpu_time = false
  ## If true, compute and report the sum of all non-idle CPU states.
  report_active = false


# Read metrics about disk usage by mount point
[[inputs.disk]]
  ## By default stats will be gathered for all mount points.
  ## Set mount_points will restrict the stats to only the specified mount points.
  # mount_points = ["/"]

  ## Ignore mount points by filesystem type.
  ignore_fs = ["tmpfs", "devtmpfs", "devfs", "overlay", "aufs", "squashfs"]


# Read metrics about disk IO by device
[[inputs.diskio]]

```


## 树莓派安装
```
wget https://dl.influxdata.com/telegraf/releases/telegraf_1.7.0-1_armhf.deb
sudo dpkg -i telegraf_1.7.0-1_armhf.deb
rm telegraf_1.7.0-1_armhf.deb
sudo systemctl status telegraf
```

如果本文对您有所帮助，请给个`start`，您的支持是我创作的最大动力，谢谢！

