## 腾讯游戏大数据运维

### 1.DNS解析顺序是什么？怎么修改默认解析顺序？

```
在linux中，往往解析一个域名时，先会找/etc/hosts文件，如果/etc/hosts文件没有对应，才会去找DNS，那么有什么方式，让主机先找DNS呢？
当然有，在/etc/nsswitch.conf这个文件里定义，
#vi /etc/nsswitch.conf
hosts:      files dns    //默认配置
从配置文件就可以看出系统是先files（/etc/hosts）解析，再从dns（/etc/resolv.conf）解析。
修改成下面这样：
hosts:      dns files
这样，你的主机就会先去找DNS，在去找hosts了
```

### 2.登入shell和非登入shell有什么区别？

#### 现象

**登录shell：**是需要用户名、密码登录后才能进入的shell（或者通过"--login"选项生成的shell）。
**非登录shell：**当然就不需要输入用户名和密码即可打开的Shell，例如：直接命令“bash”就是打开一个新的非登录shell，在Gnome或KDE中打开一个“终端”（terminal）窗口程序也是一个非登录shell。

#### 退出

执行exit命令，退出一个shell（登录或非登录shell）；

执行logout命令，退出登录shell（不能退出非登录shell）。

#### 加载启动脚本的顺序

登入shell加载启动脚本的顺序为`/etc/profile → /etc/profile.d → .bash_profile → .bashrc → /etc/bashrc`

非登入shell加载启动脚本的顺序`.bashrc → /etc/bashrc → /etc/profile.d`

### 3.proc文件系统的作用

proc文件系统是一个伪文件系统，他只存在于内存中，而不占用外用空间。他以文件系统的方式为访问系统内核数据的操作提供接口。用户和应用程序可以通过proc得到系统的信息，并可以改变内核的某些参数。由于系统的信息，如进程是动态改变的，所有用户或者应用程序读取proc文件时，proc文件系统是动态从系统内核读取所需信息并提交。

```
cmdline：系统启动时输入给内核命令行参数 
cpuinfo：CPU的硬件信息 (型号, 家族, 缓存大小等)  
devices：主设备号及设备组的列表，当前加载的各种设备（块设备/字符设备） 
dma：使用的DMA通道 
filesystems：当前内核支持的文件系统，当没有给 mount(1) 指明哪个文件系统的时候， mount(1) 就依靠该文件遍历不同的文件系统
interrupts ：中断的使用及触发次数，调试中断时很有用 
ioports I/O：当前在用的已注册 I/O 端口范围 
kcore：该伪文件以 core 文件格式给出了系统的物理内存映象(比较有用)，可以用 GDB 查探当前内核的任意数据结构。该文件的总长度是物理内存 (RAM) 的大小再加上 4KB
kmsg：可以用该文件取代系统调用 syslog(2) 来记录内核日志信息，对应dmesg命令
kallsym：内核符号表，该文件保存了内核输出的符号定义, modules(X)使用该文件动态地连接和捆绑可装载的模块
loadavg：负载均衡，平均负载数给出了在过去的 1、 5,、15 分钟里在运行队列里的任务数、总作业数以及正在运行的作业总数。
locks：内核锁 。
meminfo物理内存、交换空间等的信息，系统内存占用情况，对应df命令。
misc：杂项 。
modules：已经加载的模块列表，对应lsmod命令 。
mounts：已加载的文件系统的列表，对应mount命令，无参数。
partitions：系统识别的分区表 。
slabinfo：sla池信息。
stat：全面统计状态表，CPU内存的利用率等都是从这里提取数据。对应ps命令。
swaps：对换空间的利用情况。 
version：指明了当前正在运行的内核版本。
```



4.内核调优在哪里修改？

