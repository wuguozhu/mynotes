# TIG(Telegraf-Influxdb-Grafana) Stack Installs

## Telegraf install

### 要求

安装Telegraf软件包可能需要`root`或具有管理员权限才能成功完成。

### 连接

Telegraf提供多个服务[输入插件](http://docs.influxdata.com/telegraf/v1.10/plugins/inputs/)，可能需要自定义端口。可以通过配置文件修改所有端口映射，配置文件位于`/etc/telegraf/telegraf.conf`默认安装位置。

### 时间同步

Telegraf使用主机的UTC本地时间为数据分配时间戳。使用网络时间协议（NTP）同步主机之间的时间; 如果主机的时钟与NTP不同步，则数据的时间戳可能不准确。

### 安装

本教程只适配Centos系统，若需要其他系统则可访问[Telegraf-1.10安装](http://docs.influxdata.com/telegraf/v1.10/introduction/installation/)选择对应的系统版本进行安装。

#### YUM安装

**RedHat和CentOS：**使用`yum`包管理器安装最新的稳定版Telegraf ：

```sh
cat <<EOF | sudo tee /etc/yum.repos.d/influxdb.repo
  [influxdb]
  name = InfluxDB Repository - RHEL \$releasever
  baseurl = https://repos.influxdata.com/rhel/\$releasever/\$basearch/stable
  enabled = 1
  gpgcheck = 1
  gpgkey = https://repos.influxdata.com/influxdb.key
  EOF
```

将存储库添加到`yum`配置后，通过运行以下命令安装并启动Telegraf服务：

```sh
sudo yum install telegraf
```

#### 离线安装

本教程只适配Centos系统，若需要其他系统则可访问[Telegraf下载页](https://portal.influxdata.com/downloads/)选择对应的系统版本进行安装。

```sh
wget https://dl.influxdata.com/telegraf/releases/telegraf-1.10.1-1.x86_64.rpm
sudo yum localinstall telegraf-1.10.1-1.x86_64.rpm
```

启动telegraf

```sh
# sentos 6
sudo service telegraf start
# sentos 7
sudo systemctl start telegraf
```

## Influxdb Install

### 安装要求

可能需要安装InfluxDB软件包`root`或具有管理员权限才能成功完成。

### Influxdb 网络端口

InfluxDB默认使用以下网络端口：

- TCP端口`8086`可用于使用InfluxDB HTTP API进行客户端 - 服务器通信。
- TCP端口`8088`可用于RPC服务以执行备份和还原操作。

除了上面的端口，InfluxDB还提供了多个可能需要[自定义端口的](http://docs.influxdata.com/influxdb/v1.7/administration/ports/)插件。可以通过[配置文件](http://docs.influxdata.com/influxdb/v1.7/administration/config)修改所有端口映射，[配置文件](http://docs.influxdata.com/influxdb/v1.7/administration/config)位于`/etc/influxdb/influxdb.conf`默认安装位置。

### 时间同步

InfluxDB使用主机的UTC本地时间为数据分配时间戳并用于协调目的。使用网络时间协议（NTP）同步主机之间的时间; 如果主机的时钟与NTP不同步，写入InfluxDB的数据的时间戳可能不准确。

### 安装

本教程只适配Centos系统，若需要其他系统则可访问[Influxdb-1.7安装](http://docs.influxdata.com/influxdb/v1.7/introduction/installation/)选择对应的系统版本进行安装。

Red Hat和CentOS用户可以使用`yum`包管理器安装最新稳定版本的InfluxDB ：

```sh
cat <<EOF | sudo tee /etc/yum.repos.d/influxdb.repo
[influxdb]
name = InfluxDB Repository - RHEL \$releasever
baseurl = https://repos.influxdata.com/rhel/\$releasever/\$basearch/stable
enabled = 1
gpgcheck = 1
gpgkey = https://repos.influxdata.com/influxdb.key
EOF
```

将存储库添加到`yum`配置后，通过运行以下命令安装并启动InfluxDB服务：

```sh
sudo yum install influxdb
```

#### 离线安装

本教程只适配Centos系统，若需要其他系统则可访问[Influxdb下载页](https://portal.influxdata.com/downloads/)选择对应的系统版本进行安装。

```sh
wget https://dl.influxdata.com/influxdb/releases/influxdb-1.7.5.x86_64.rpm
sudo yum localinstall influxdb-1.7.5.x86_64.rpm
```

启动Telegraf

```sh
# centos 6
sudo service influxdb start
# centos 7
sudo systemctl start influxdb
```

### 配置Influxdb

系统具有每个配置文件设置的内部默认值。使用该`influxd config`命令查看默认配置设置。

本地配置文件（`/etc/influxdb/influxdb.conf`）中的大多数设置都被注释掉了; 所有注释掉的设置将由内部默认值确定。本地配置文件中的任何未注释的设置都会覆盖内部默认值。请注意，本地配置文件不需要包含每个配置设置。

使用配置文件启动InfluxDB有两种方法：

- 使用以下`-config` 选项将进程指向正确的配置文件：

  ```sh
  influxd -config /etc/influxdb/influxdb.conf
  ```

- 将环境变量设置为`INFLUXDB_CONFIG_PATH`配置文件的路径并启动该过程。例如：

  ```sh
  echo $INFLUXDB_CONFIG_PATH
  /etc/influxdb/influxdb.conf
  
  influxd
  ```

InfluxDB首先检查`-config`选项，然后检查环境变量。有关更多信息，请参阅[配置](http://docs.influxdata.com/influxdb/v1.7/administration/config/)文档。

### 数据和WAL目录权限

确保存储数据和预[写日志](http://docs.influxdata.com/influxdb/v1.7/concepts/glossary#wal-write-ahead-log)（WAL）的目录对于运行该`influxd`服务的用户是可写的。

**注意：**如果数据和WAL目录不可写，则`influxd`服务将无法启动。

有关`data`和`wal`目录路径的信息，请参阅[配置InfluxDB](http://docs.influxdata.com/influxdb/v1.7/administration/config/)文档的[数据设置](http://docs.influxdata.com/influxdb/v1.7/administration/config/#data-settings)部分。

### InfluxDB 权限

备注：如果在启动或使用时发现有权限问题

```sh
chown influxdb:influxdb /mnt/influx
chown influxdb:influxdb /mnt/db
```

## Grafana 安装

### 安装要求

可能需要安装InfluxDB软件包`root`或具有管理员权限才能成功完成。

### 安装

#### YUM安装

Red Hat和CentOS用户可以使用`yum`包管理器安装最新稳定版本的Grafana ：

```sh
cat /etc/yum.repos.d/grafana.repo
[grafana]
name=grafana
baseurl=https://packages.grafana.com/oss/rpm
repo_gpgcheck=1
enabled=1
gpgcheck=1
gpgkey=https://packages.grafana.com/gpg.key
sslverify=1
sslcacert=/etc/pki/tls/certs/ca-bundle.crt
```

然后通过`yum`命令安装Grafana 。

```sh
$ sudo yum install grafana -y
```

#### 离线安装

```sh
$ wget https://dl.grafana.com/oss/release/grafana-5.4.2-1.x86_64.rpm
$ sudo yum install initscripts fontconfig
## sudo rpm -Uvh <local rpm package>
$ sudo rpm grafana-5.4.2-1.x86_64.rpm
## 或者使用 sudo rpm -i --nodeps <local rpm package>
$ sudo rpm -i --nodeps grafana-5.4.2-1.x86_64.rpm
```

### 默认安装配置

- 安装二进制文件 `/usr/sbin/grafana-server`
- 将init.d脚本复制到 `/etc/init.d/grafana-server`
- 安装默认文件（环境变量） `/etc/sysconfig/grafana-server`
- 将配置文件复制到 `/etc/grafana/grafana.ini`
- 安装systemd服务（如果systemd可用）名称 `grafana-server.service`
- 默认配置使用日志文件 `/var/log/grafana/grafana.log`
- 默认配置指定sqlite3数据库 `/var/lib/grafana/grafana.db`

### 启动Grafana服务

您可以通过运行以下命令启动Grafana：

```sh
$ sudo service grafana-server start
```

这是包安装期间创建`grafana-server`的`grafana`用户身份启动进程。默认HTTP端口是`3000`，默认用户和组是`admin`。

默认的登录名和密码:`admin/admin`

如果忘记默认的用户名密码则用以下命令重置：

```sh
$ sudo /sbin/chkconfig --add grafana-server
```

使用`systemd`启动(centos 7方式)

```sh
$ systemctl daemon-reload
$ systemctl start grafana-server
$ systemctl status grafana-server
```

启用systemd服务以启动时启动(随主机启动配置)

```sh
sudo systemctl enable grafana-server.service
```

### 启动配置

systemd服务文件和init.d脚本都使用位于`/etc/sysconfig/grafana-server`启动后端时使用的环境变量的文件。在这里，您可以覆盖日志目录，数据目录和其他变量。

### 日志

默认情况下，Grafana日志保存于： `/var/log/grafana`

### 数据库

默认配置指定位于的sqlite3数据库`/var/lib/grafana/grafana.db`。请在升级前备份此数据库。您还可以使用MySQL或Postgres作为Grafana数据库，如[配置页面中](http://docs.grafana.org/installation/configuration/#database)所详述。

### 其他配置

配置文件位于`/etc/grafana/grafana.ini`。有关所有这些选项的详细信息，请转到“ [配置”](http://docs.grafana.org/installation/configuration/)页

更详细安装过程请访问官网[Grafana官方安装页](http://docs.grafana.org/installation/rpm/)

