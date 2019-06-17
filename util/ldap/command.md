### Ldap常用命名

用户组ldif文件

```shell
[root@hadoop0 ldap]# cat anan-group.ldif
dn: cn=ranan,ou=Group,dc=macro,dc=com
objectClass: posixGroup
objectClass: top
cn: ranan
userPassword: {SSHA}HeN0fwslTm2/gYsWRbFyTXIolgqZ0Qpc
gidNumber: 1006

dn: cn=wanan,ou=Group,dc=macro,dc=com
objectClass: posixGroup
objectClass: top
cn: wanan
userPassword: {SSHA}AHnuGlB99W84ZEEOx9kogl+vTYH0/t4n
gidNumber: 1007
[root@hadoop0 ldap]#
```

用户ldif文件

```shell
[root@hadoop0 ldap]# cat anan-user.ldif
dn: uid=ranan,ou=People,dc=macro,dc=com
uid: ranan
cn: ranan
objectClass: account
objectClass: posixAccount
objectClass: top
objectClass: shadowAccount
userPassword: {SSHA}HeN0fwslTm2/gYsWRbFyTXIolgqZ0Qpc
shadowLastChange: 17564
loginShell: /bin/false
uidNumber: 1006
gidNumber: 1006
homeDirectory: /var/lib/ranan

dn: uid=wanan,ou=People,dc=macro,dc=com
uid: wanan
cn: wanan
objectClass: account
objectClass: posixAccount
objectClass: top
objectClass: shadowAccount
userPassword: {SSHA}AHnuGlB99W84ZEEOx9kogl+vTYH0/t4n
shadowLastChange: 17564
loginShell: /bin/bash
uidNumber: 1007
gidNumber: 1007
homeDirectory: /var/lib/wanan
```

注意：每个dn以空行分开

用户密码生成

```shell
slappasswd -h {SSHA} -s password
e.g:
slappasswd -h {SSHA} -s ranan
```



#### 添加用户

```
ldapadd -D "cn=Manager,dc=macro,dc=com" -W -x -f <ldif file>
e.g:
ldapadd -D "cn=Manager,dc=macro,dc=com" -W -x -f 
```

**查看用户**

```
ldapsearch -h hadoop0.macro.com -b "dc=macro,dc=com" -D "cn=Manager,dc=macro,dc=com" -W | grep dn
```

