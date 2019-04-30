# Helm

## 获取Chart

```shell
$ helm fetch stable/mysql --version 0.2.8 --untar
$ ls mysql/
Chart.yaml README.md templates values.yaml
```

利用helm lint命令检查下载的chart是否存在问题：

```shell
$ helm lint mysql
==> Linting mysql
Lint OK
1 chart(s) linted, no failures
```



## Chart结构

创建helm

```shell
[root@hadoop1]~# helm create mychart
Creating mychart
```

查看以上chart结构

```shell
[root@hadoop1]~/mychart# tree
.
├── charts
├── Chart.yaml
├── templates
│   ├── deployment.yaml
│   ├── _helpers.tpl
│   ├── ingress.yaml
│   ├── NOTES.txt
│   ├── service.yaml
│   └── tests
│       └── test-connection.yaml
└── values.yaml
```

生成chart目录里有Chart.yaml, values.yaml 与 NOTES.txt等文件，下面分别对chart中几个重要文件解释：

- Chart.yaml 包含了chart的metadata，描述了Chart名称、描述信息与版本。

- values.yaml：存储了模板文件变量。
- templates/：记录了全部模板文件。
- charts/：依赖chart存储路径。
- NOTES.txt：给出了部署后的信息，例如如何使用chart、列出默认的设置等等。

## 安装方式

- 指定chart: helm install stable/mariadb
- 指定打包的chart: helm install ./nginx-1.2.3.tgz
- 指定打包目录: helm install ./nginx
- 指定chart包URL: helm install <https://example.com/charts/nginx-1.2.3.tgz>
- 将当前目录打包为tgz:  helm package -d tardest 待压缩chart1 待压缩chart2

覆盖chart中的默认值，通过指定配置文件方式：

```shell
[root@hadoop1]~# helm install -f myvalues.yaml ./mychart
## 通过传参方式，例如：–set key=value
[root@hadoop1]~# helm install --set name=prod ./mychart
```

安装release名称为mysql例子如下，请注意NOTES中对Mysql的使用说明：

```shell
[root@hadoop1]~# helm install -n mysql -f mysql/values.yaml --set resources.requests.memory=512Mi mysql
```

通过helm status查看release状态：

```shell
[root@hadoop1]~# helm status mysql
LAST DEPLOYED: Tue Apr 12 12:31:49 2019
NAMESPACE: default
STATUS: DEPLOYED
```
或通过helm list -a查看全部的release，tag “-a”是查看全部的release，包括已部署、部署失败、正在删除、已删除release等。


```
[root@hadoop1]~# helm list -a
```



## 更新Release

Helm使用helm upgrade更新已安装的release：

```shell
[root@hadoop1]~# helm upgrade mysql -f mysql/values.yaml --set resources.requests.memory=1024Mi mysql
```

查看指定release的历史部署版本信息：

```shell
[root@hadoop1]~# helm hist  mysql
REVISION    UPDATED                        STATUS           CHART          DESCRIPTION
1           Tue Apr 12 12:41:49 2019       SUPERSEDED       mysql-0.2.8    Install complete
2           Tue Apr 12 12:44:42 2019       DEPLOYED         mysql-0.2.8    Upgrade complete
```

查看指定release的历史版本部署时部分配置信息，以resources.requests.memory为例，符合查看部署符合预期：即第一次部署resources.requests.memory设置为512Mi，第二次的升级resources.requests.memory设置为1024Mi：

```shell
[root@hadoop1]~# helm get --revision 1 mysql
resources:
requests:
cpu: 100m
memory: 512Mi

[root@hadoop1]~# helm get --revision 2 mysql
resources:
requests:
cpu: 100m
memory: 1024Mi
```

## 版本回滚

```shell
回滚到第一次的版本：

[root@hadoop1]~# helm rollback --debug mysql 1
[debug] Created tunnel using local port: '60303'
[debug] SERVER: "localhost:60303"
Rollback was a success! Happy Helming!
```
查看mysql release的版本信息，当前已经回滚到REVISION为1的版本：
```shell
[root@hadoop1]~# helm hist mysql
REVISION           UPDATED                    STATUS        CHART          DESCRIPTION
1                  Tue Apr 12 12:41:49 2019   SUPERSEDED    mysql-0.2.8    Install complete
2                  Tue Apr 12 12:44:42 2019   SUPERSEDED    mysql-0.2.8    Upgrade complete
3                  Tue Apr 12 12:48:45 2019   DEPLOYED      mysql-0.2.8    Rollback to 1
```



## 删除chart

利用helm delete命令删除一个chart：

```shell
[root@hadoop1]~# helm delete mysql
release "mysql" deleted
```

确认chart是否删除：

```shell
[root@hadoop1]~# helm ls -a mysql
NAME     REVISION      UPDATED                     STATUS      CHART           NAMESPACE
mysql    3             Tue Apr 12 12:56:25 2019    DELETED     mysql-0.2.8     defaul
```

即使删除的chart，其发布的历史信息还是继续被保存。

```shell
[root@hadoop1]~# helm hist mysql
```

可以恢复一个已经删除的release：

```shell
[root@hadoop1]~# helm rollback --debug mysql 2
```

如果希望彻底删除一个release，可以用如下命令：

```shell
[root@hadoop1]~# helm delete --purge mysql
```

