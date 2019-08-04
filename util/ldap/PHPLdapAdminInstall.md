# PHPLdapAdmin的安装及使用

## 前言

OpenLdap方便集成于各种SSO系统，但是命令操作极其复杂，且容易出错；本篇文章为实践OpenLDAP管理工具Phpldapadmin的安装及使用。

- 内容概述

1.环境准备及部署

2.phpldapadmin的访问及使用

- 测试环境

1.CM和CDH版本为5.16.1

2.Phpldapadmin版本为1.2.3

## 环境准备及部署

1.安装PHP环境及依赖

```shell
yum -y install httpd php php-ldap php-gd php-mbstring php-pear php-bcmath php-xml
```

![1564390742771](.image/PHPLdapAdminInstall.assets/1564390742771.png)

2.下载最新的phpldapadmin安装包

```shell
wget https://nchc.dl.sourceforge.net/project/phpldapadmin/phpldapadmin-php5/1.2.3/phpldapadmin-1.2.3.tgz
```

![1564391005152](.image/PHPLdapAdminInstall.assets/1564391005152.png)

3.将下载的压缩包解压至/var/www/html目录下

```shell
tar -zxf phpldapadmin-1.2.3.tgz
mv phpldapadmin-1.2.3 phpldapadmin
```

![1564391561019](.image/PHPLdapAdminInstall.assets/1564391561019.png)

![1564392702759](.image/PHPLdapAdminInstall.assets/1564392702759.png)

4.进入/var/www/html/phpldapadmin/conf目录下，并将config.php.example重命名为config.php文件

```shell
cp config.php.example config.php
```

![1564391674339](.image/PHPLdapAdminInstall.assets/1564391674339.png)

5.编辑config.php的，将OpenLDAP的信息添加到该配置文件中

```php
$servers->setValue('server','host','hadoop0.macro.com');
$servers->setValue('server','port',389);
$servers->setValue('server','base',array('dc=macro,dc=com'));
$servers->setValue('login','auth_type','cookie');
$servers->setValue('login','bind_id','cn=Manager,dc=macro,dc=com');
$servers->setValue('login','bind_pass','123456');
$servers->setValue('server','tls',false);
```

主要配置LDAP的服务器地址，Base DN，管理员账号及密码（可选择性的配置）

6.配置完成后启动httpd服务

```shell
[root@hadoop1 config]# systemctl  restart httpd
[root@hadoop1 config]# systemctl  status httpd
```

![1564392506295](.image/PHPLdapAdminInstall.assets/1564392506295.png)



## phpldapadmin访问及使用

1.在浏览器输入http://192.168.0.191/phpldapadmin访问

![1564392777176](.image/PHPLdapAdminInstall.assets/1564392777176.png)

2.点击“登录”，配置文件中配置了管理员的账号所以默认显示为管理员账号

![1564393166447](.image/PHPLdapAdminInstall.assets/1564393166447.png)

3.输入管理员密码进行认证，登录成功后显示如下界面：

![1564393232786](.image/PHPLdapAdminInstall.assets/1564393232786.png)

## 创建OpenLDAP基础域

1.点击“创建新条目”，选择“Organisational Unit”

![1564393479830](.image/PHPLdapAdminInstall.assets/1564393479830.png)

2.创建基础域School

![1564393523249](.image/PHPLdapAdminInstall.assets/1564393523249.png)

3.点击“创建对象”

![1564393613179](.image/PHPLdapAdminInstall.assets/1564393613179.png)

4.点击“提交”完成创建

![1564393701464](.image/PHPLdapAdminInstall.assets/1564393701464.png)

备注：我发现基础域的名称都是大写的所以更名了一下

## 创建OpenLDAP组

1.在School下面创建一个student组

![1564393801694](.image/PHPLdapAdminInstall.assets/1564393801694.png)

2.选择“Posix Group”

![1564393885265](.image/PHPLdapAdminInstall.assets/1564393885265.png)

3.输入组名并选择wuguozhu用户属于该组

![1564393988431](.image/PHPLdapAdminInstall.assets/1564393988431.png)

4.点击“创建对象”

![1564394041111](.image/PHPLdapAdminInstall.assets/1564394041111.png)

5.点击“提交”完成student组创建

![1564394122136](.image/PHPLdapAdminInstall.assets/1564394122136.png)

6.登录服务器查看wuguozhu用户拥有的组

```
[root@hadoop1 html]#  systemctl restart sssd
[root@hadoop1 html]# id wuguozhu
uid=1000(wuguozhu) gid=1000(wuguozhu) groups=1000(wuguozhu),1001(supergroup),500(student)
[root@hadoop1 html]#
```

![1564394239562](.image/PHPLdapAdminInstall.assets/1564394239562.png)

备注：有必要时可以删除sssd缓存`rm -rf /var/lib/sss/db/cache_default.ldb `

## 创建OpenLDAP用户

1.在Users基础域下创建一个zhangsan的用户

![1564394432439](.image/PHPLdapAdminInstall.assets/1564394432439.png)

2.选择默认“User Account”

![1564394494226](.image/PHPLdapAdminInstall.assets/1564394494226.png)

3.填写用户基本信息

![1564394666889](.image/PHPLdapAdminInstall.assets/1564394666889.png)

![1564394810443](.image/PHPLdapAdminInstall.assets/1564394810443.png)

4.点击“创建对象”

![1564394825647](.image/PHPLdapAdminInstall.assets/1564394825647.png)

![1564394864242](.image/PHPLdapAdminInstall.assets/1564394864242.png)

6.登录服务器查看zsan用户

```shell
id zsan
```

