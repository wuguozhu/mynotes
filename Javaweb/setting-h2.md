# SpringBoot集成H2

## 1.添加依赖

添加`pom.xml`依赖

```xml
<dependency>
    <groupId>com.h2database</groupId>
    <artifactId>h2</artifactId>
    <scope>runtime</scope>
</dependency>
```

## 实体类

简单的图书实体类 

```java
package com.anan.entity;
import lombok.Data;
import org.springframework.data.annotation.Id;
@Data
public class Book {
    @Id
    private Integer id;       	//图书ID.
    private String name;  			//图书名字.
    private Integer number;			//图书数量.
    private Integer price;			//图书价格.
    private String printshop;		//出版社.
}
```

## 3.配置数据源

将`application.yml`配置文件数据源连接进行如下修改。

```yaml
spring:
  datasource:
    url: jdbc:h2:mem:h2test;DB_CLOSE_DELAY=-1;DB_CLOSE_ON_EXIT=FALSE
    platform: h2
    username: sa
    password:
    driverClassName: org.h2.Driver
    schema: classpath:db/schema.sql
    data: classpath:db/data.sql
```

## 4.数据初始化配置

添加`schema.sql`到`resource`目录下的`db`目录下(`db`目录需要自己建)

```sql
CREATE TABLE `book` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `number` int(50) NOT NULL,
  `price` int(32) NOT NULL,
  `printshop` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
```

添加`data.sql`到`resource`目录下的`db`目录下

```sql
INSERT INTO book(id,name,number,price,printshop)VALUES (10,'雪山飞猪',100,45.0,'清华大学出版社');
INSERT INTO book(id,name,number,price,printshop)VALUES (11,'雪山飞鸡',100,46.0,'清华大学出版社');
INSERT INTO book(id,name,number,price,printshop)VALUES (12,'雪山飞鸭',100,47.0,'清华大学出版社');
INSERT INTO book(id,name,number,price,printshop)VALUES (13,'雪山飞狗',100,48.0,'清华大学出版社');
INSERT INTO book(id,name,number,price,printshop)VALUES (14,'雪山飞牛',100,49.0,'清华大学出版社');
INSERT INTO book(id,name,number,price,printshop)VALUES (15,'雪山飞马',100,50.0,'清华大学出版社');
```

