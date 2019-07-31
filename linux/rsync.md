# rsync

rsync功能rsync是Unix系统的文件传输程序。rsync使用“rsync算法”，它提供了一种非常快速的方法来使远程文件同步。它通过仅发送链接中文件的差异来实现这一点，而不需要事先在链接的一端存在两组文件。

rsync的一些功能包括

- 可以更新整个目录树和文件系统
- 可选地保留符号链接，硬链接，文件所有权，权限，设备和时间
- 不需要特殊权限即可安装
- 内部流水线操作可减少多个文件的延迟
- 可以使用rsh，ssh或直接套接字作为传输
- 支持[匿名rsync](http://dslab.lzu.edu.cn:8080/members/wangbj/wangbaojun/howtos/rsync-mirror-HOWTO/rsync-mirroring02.html)，非常适合镜像

软件原理：[rsync同步机制、过程、工作原理](http://blog.uouo123.com/post/692.html)

## 语法

```shell
rsync [OPTION]... SRC DEST
rsync [OPTION]... SRC [USER@]host:DEST
rsync [OPTION]... [USER@]HOST:SRC DEST
rsync [OPTION]... [USER@]HOST::SRC DEST
rsync [OPTION]... SRC [USER@]HOST::DEST
rsync [OPTION]... rsync://[USER@]HOST[:PORT]/SRC [DEST]
```

**对应于以上六种命令格式，rsync有六种不同的工作模式：**

1.拷贝本地文件。当SRC和DES路径信息都不包含有单个冒号":"分隔符时就启动这种工作模式。如：`rsync -a /data /backup`

2.使用一个远程shell程序(如rsh、ssh)来实现将本地机器的内容拷贝到远程机器。当DST路径地址包含单个冒号":"分隔符时启动该模式。如：`rsync -avz *.c foo:src`

3.使用一个远程shell程序(如rsh、ssh)来实现将远程机器的内容拷贝到本地机器。当SRC地址路径包含单个冒号":"分隔符时启动该模式。如：`rsync -avz foo:src/bar /data`

4.从远程rsync服务器中拷贝文件到本地机。当SRC路径信息包含"::"分隔符时启动该模式。如：`rsync -av root@192.168.78.192::www /databack`

5.从本地机器拷贝文件到远程rsync服务器中。当DST路径信息包含"::"分隔符时启动该模式。如：`rsync -av /databack root@192.168.78.192::www`

6.列远程机的文件列表。这类似于rsync传输，不过只要在命令中省略掉本地机信息即可。如：`rsync -v rsync://192.168.78.192/www`

## 参数选项

```shell
-v, --verbose 详细模式输出。 
-q, --quiet 精简输出模式。 
-c, --checksum 打开校验开关，强制对文件传输进行校验。 使用的是MD4文件校验
-a, --archive 归档模式，表示以递归方式传输文件，并保持所有文件属性，等于-rlptgoD。 
-r, --recursive 对子目录以递归模式处理。 
-R, --relative 使用相对路径信息。 
-b, --backup 创建备份，也就是对于目的已经存在有同样的文件名时，将老的文件重新命名为~filename。可以使用--suffix选项来指定不同的备份文件前缀。
--backup-dir 将备份文件(如~filename)存放在在目录下。 -suffix=SUFFIX 定义备份文件前缀。 
-u, --update 仅仅进行更新，也就是跳过所有已经存在于DST，并且文件时间晚于要备份的文件，不覆盖更新的文件。 
-l, --links 保留软链结。 
-L, --copy-links 想对待常规文件一样处理软链结。 
--copy-unsafe-links 仅仅拷贝指向SRC路径目录树以外的链结。 
--safe-links 忽略指向SRC路径目录树以外的链结。 
-H, --hard-links 保留硬链结。 
-p, --perms 保持文件权限。 
-o, --owner 保持文件属主信息。 
-g, --group 保持文件属组信息。 
-D, --devices 保持设备文件信息。 
-t, --times 保持文件时间信息。 
-S, --sparse 对稀疏文件进行特殊处理以节省DST的空间。 
-n, --dry-run现实哪些文件将被传输。 
-w, --whole-file 拷贝文件，不进行增量检测。 
-x, --one-file-system 不要跨越文件系统边界。 
-B, --block-size=SIZE 检验算法使用的块尺寸，默认是700字节。 
-e, --rsh=command 指定使用rsh、ssh方式进行数据同步。
--rsync-path=PATH 指定远程服务器上的rsync命令所在路径信息。 
-C, --cvs-exclude 使用和CVS一样的方法自动忽略文件，用来排除那些不希望传输的文件。 
--existing 仅仅更新那些已经存在于DST的文件，而不备份那些新创建的文件。 
--delete 删除那些DST中SRC没有的文件。 
--delete-excluded 同样删除接收端那些被该选项指定排除的文件。
--delete-after 传输结束以后再删除。 
--ignore-errors 及时出现IO错误也进行删除。 
--max-delete=NUM 最多删除NUM个文件。 
--partial 保留那些因故没有完全传输的文件，以是加快随后的再次传输。 
--force 强制删除目录，即使不为空。 
--numeric-ids 不将数字的用户和组id匹配为用户名和组名。 
--timeout=time ip超时时间，单位为秒。 
-I, --ignore-times 不跳过那些有同样的时间和长度的文件。 
--size-only 当决定是否要备份文件时，仅仅察看文件大小而不考虑文件时间。 
--modify-window=NUM 决定文件是否时间相同时使用的时间戳窗口，默认为0。 
-T --temp-dir=DIR 在DIR中创建临时文件。 
--compare-dest=DIR 同样比较DIR中的文件来决定是否需要备份。 
-P 等同于 --partial。 
--progress 显示备份过程。 
-z, --compress 对备份的文件在传输时进行压缩处理。
--exclude=PATTERN 指定排除不需要传输的文件模式。
--include=PATTERN 指定不排除而需要传输的文件模式。
--exclude-from=FILE 排除FILE中指定模式的文件。
--include-from=FILE 不排除FILE指定模式匹配的文件。 
--version 打印版本信息。 
--address 绑定到特定的地址。 
--config=FILE 指定其他的配置文件，不使用默认的rsyncd.conf文件。 
--port=PORT 指定其他的rsync服务端口。 
--blocking-io 对远程shell使用阻塞IO。 
-stats 给出某些文件的传输状态。 
--progress 在传输时现实传输过程。
--log-format=formAT 指定日志文件格式。 
--password-file=FILE 从FILE中得到密码。 
--bwlimit=KBPS 限制I/O带宽，KBytes per second。 
-h, --help 显示帮助信息。
```

> 现在是9102年，如果版本比较老，请直接使用`rsync --help`查看

## 关于内存使用

关于内存的使用官网是这么回答的"3.0.0之前的Rsync版本始终构建要在开始时传输的整个文件列表，并将其保存在整个运行的内存中。Rsync需要大约100个字节来存储一个文件的所有相关信息，因此（例如）具有800,000个文件的运行将消耗大约80M的内存。-H和--delete进一步增加内存使用量。

3.0.0版本通过不存储特定文件不需要的字段，略微减少了每个文件使用的内存。它还引入了一种增量递归模式，该模式以块的形式构建文件列表，并且只要需要就将每个块保存在内存中。此模式可以显着减少内存使用量，但只有双方都是3.0.0或更高版本才能使用此模式，并且未使用rsync当前在此模式下无法处理的某些选项。"

在我的亲身实践中，我在同一台主机两个磁盘间复制115G大概4万个文件使用的内存和CPU并不算高。

## 关于内存不足

关于内存不足官网是这么回答的"运行rsync时“内存不足”的通常原因是您正在传输大量的文件。文件的大小无关紧要，只有文件的总数。如果内存有问题，首先尝试使用增量递归模式：将双方升级到rsync 3.0.0或更高版本，并避免禁用增量递归的选项（例如，使用 `--delete-delay`而不是`--delete-after`）。如果无法做到这一点，您可以使用`--relative`和/或exclude规则将rsync运行分解为在各个子目录上运行的较小块。"

## 关于rsync和scp的区别

在多年以前我还是个孩子，在一次面试中被人问了rsync和scp的区别我懵逼了，下面就是他们之间的区别

- rsync只对差异文件做更新，可以做增量或全量备份；而scp只能做全量备份。简单说就是rsync只传修改了的部分，如果改动较小就不需要全部重传，所以rsync备份速度较快；默认情况下，rsync通过比较文件的最后修改时间（mtime）和文件的大小（size）来确认哪些文件需要被同步过去。
- rsync是分块校验+传输，scp是整个文件传输。rsync比scp有优势的地方在于单个大文件的一小部分存在改动时，只需传输改动部分，无需重新传输整个文件。如果传输一个新的文件，理论上rsync没有优势；
- rsync不是加密传输，而scp是加密传输，使用时可以按需选择。

## 使用

基础的 `rsync` 命令很简单

```
rsync -av SRC DST
```

假设我现在有一个3T的数据目录需要更换磁盘，这时就需要跨盘传输速度较慢传输时间很长`-c` 选项告诉 `rsync` 使用文件校验和而不是时间戳来决定改变的文件，这通常消耗的时间更久和更高的磁盘IO。

```shell
rsync -ca /var/lib/cdsw/ /data1
```

在一次数据迁移中，下面是我的方案

```shell
date && time rsync -ac --partial --bwlimit 800000 --delete  /data0/backup /data1/backup && date
```

如果你怕这个程序占用了大量的系统资源可以用下面的办法限制一下，在一次做数据迁移的方案中下面是我的备用方案

```shell
ionice -c 3 nice -n 12 rsync -ac  --partial --bwlimit 800000 --delete  /data0/backup /data1/backup1
```

至于`ionice`、`nice` 干嘛用的，自行查阅资料，网上很多-

本文参考：

[[1]官方链接](https://rsync.samba.org/)

[[2]How to use advanced rsync for large Linux backups](https://opensource.com/article/19/5/advanced-rsync)

[3]https://serverfault.com/questions/55560/nice-rsync-on-remote-machine/727567

[4]https://rsync.samba.org/FAQ.html#4







