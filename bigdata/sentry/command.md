



```mysql
# 使用beeline登录hive
!connect jdbc:hive2://hadoop0.macro.com:10000/;principal=hive/hadoop0.macro.com@MACRO.COM

# 创建数据库
create database buadb;
create database bubdb;
create database bucdb;

# 创建部门abc角色
create role buarole;
create role bubrole;
create role bucrole;

# 授权
#grant select on table test to role read;
grant all on database buadb. to role buarole;
grant all on database bubdb to role bubrole;
grant all on database bucdb to role bubrole;

# 将各部门角色授权给各部门用户组(系统用户组)
grant role buarole to group bua;
grant role bubrole to group bub;
grant role bucrole to group buc;

```

