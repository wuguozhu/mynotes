

## 用户管理命令

### 管理员用户管理

创建一个新的管理员用户

```shell
CREATE USER <username> WITH PASSWORD '<password>' WITH ALL PRIVILEGES
# e.g:
CREATE USER alnitak WITH PASSWORD 'alnitak' WITH ALL PRIVILEGES
```

为一个已有用户**授权**管理员权限

```
GRANT ALL PRIVILEGES TO <username>
# e.g:
GRANT ALL PRIVILEGES TO wugzhu
```

取消用户权限

```
REVOKE ALL PRIVILEGES FROM <username>
# e.g:
REVOKE ALL PRIVILEGES FROM wugzhu
```

展示用户及其权限

```
SHOW USERS
```

### 非管理员用户管理

创建一个新用户

```
CREATE USER <username> WITH PASSWORD '<password>'
```

授权一个用户

```
GRANT [READ,WRITE,ALL] ON <database_name> TO <username>
```

取消权限

```
REVOKE [READ,WRITE,ALL] ON <database_name> FROM <username>
```

展示用户在不同数据库上的权限

```
SHOW GRANTS FOR <user_name>
```

### 普通用户账号功能管理

重设密码

```
SET PASSWORD FOR <username> = '<password>'
```

删除用户

```
DROP USER <username>
```



### 用户验证与授权的http错误

当验证失败时http会返回

```
HTTP 401 Unauthorized
```

