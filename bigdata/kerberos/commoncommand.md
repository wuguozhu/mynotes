**导出keytab**

```sehll
xst -k /path/to/*.keytab -norandkey <principal>
e.g:
xst -k macro.keytab -norandkey macro@MACRO.COM
```

其中principal为需要导出keytab的用户名, 如hbase/cdh2, 注意-norandkey参数不可缺少, 否则可能会导致重新生成密码, 导致keytab失效.
导出的keytab的效用等同账号密码, 请注意妥善保管.

一般CDH的keytab存放在`/var/run/cloudera-scm-agent/process`目录下，查找目录ID最大的.



**keytab认证**

```
kinit -kt hive.keytab hive/hadoop0.macro.com@MACRO.COM
```

