# Fix"ldap_add: Naming violation"

OpenLdap开启MemberOf时发生如下异常

```
[root@hadoop0 memberOf]# ldapadd -Q -Y EXTERNAL -H ldapi:/// -f  memberof_conf.ldif
adding new entry "cn=module{0},cn=config"
ldap_add: Naming violation (64)
```

解决方案：



参考：

https://tylersguides.com/guides/openldap-memberof-overlay/