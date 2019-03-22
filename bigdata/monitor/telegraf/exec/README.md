# 自定义标准输出监控

该插件可收集主机的一切可执行文件的标准输出

编辑修改Telegraf 配置文件:`/etc/telegraf/telegraf.conf`配置如下：

```toml
[[inputs.exec]]
  ## Commands array
  commands = [
    "/tmp/test.sh",
    "/usr/bin/mycollector --foo=bar",
    "/tmp/collect_*.sh"
  ]

  ## Timeout for each command to complete.
  timeout = "5s"

  ## measurement name suffix (for separating different commands)
  name_suffix = "_mycollector"

  ## Data format to consume.
  ## Each data format has its own unique set of configuration options, read
  ## more about them here:
  ## https://github.com/influxdata/telegraf/blob/master/docs/DATA_FORMATS_INPUT.md
  data_format = "influx"
```

### Example:

实例脚本如下
```sh
[root@hadoop3 ~]# cat /tmp/test.sh
#!/bin/sh
echo 'example,tag1=a,tag2=b i=42i,j=43i,k=44i'
```
> `data_format`为`influx`

在telegraf配置中配置如下，telegraf代理会定时取运行该脚本并收集其标准输出数据至数据库(influxdb)

```toml
[[inputs.exec]]
  commands = ["sh /tmp/test.sh"]
  timeout = "5s"
  data_format = "influx"
```

如果本文对您有所帮助，请给个`start`，您的支持是我创作的最大动力，谢谢！

**问题**

 **Q: My script works when I run it by hand, but not when Telegraf is running as a service.**

译文：脚本可以单独运行，但是telegraf代理不能运行

This may be related to the Telegraf service running as a different user.  The
official packages run Telegraf as the `telegraf` user and group on Linux
systems.

译文总结：这可能与作为不同用户运行的Telegraf服务有关;可以尝试在Linux上以Telegraf用户和组的身份运行Telegraf系统。

