



```shell
# 一般CDH所有组件的keytab存放在/var/run/cloudera-scm-agent/process下，寻找对应组件目录ID最大的目录下找到该组件的keytab文件。
# 认证hive登录
kinit -kt hive.keytab hive/hadoop0.anan.com@ANAN.COM

# 使用beeline连接HiveServer2
!connect jdbc:hive2://hadoop0.anan.com:10000/;principal=hive/hadoop0.anan.com@ANAN.COM

# 创建admin角色
create role admin;

# 为admin角色赋予管理员权限
grant all on server server1 to role admin;

# 将admin角色授权给hive用户组后者用户
grant role admin to group hive;

# 以上操作创建了一个admin角色：
# admin : 具有管理员权限，可以读写所有数据库，并授权给hive组（对应操作系统的组）因此hive用户

# 创建测试表
create table test (s1 string, s2 string) row format delimited fields terminated by ',';
insert into test values('a','b'),('1','2');

# 使用hive用户创建read和write角色，并授权read角色对test1表的select权限，write角色对test1表的insert权限
create role read;
grant select on table test1 to role read;

create role write;
grant insert on table test1 to role write;

# 将read角色授权给ranan用户组，write角色授权给wanan用户组 
grant role read to group ranan;
grant role write to group wanan;

 
```

