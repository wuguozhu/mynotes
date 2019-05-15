## 腾讯游戏大数据运维岗

被摩擦题

1.DNS解析顺序是什么？怎么修改默认解析顺序？

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

2.登入shell和非登入shell有什么区别？

3.proc文件系统的作用

4.内核调优在哪里修改？