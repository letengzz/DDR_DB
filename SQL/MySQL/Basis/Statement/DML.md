# 数据操作语言 DML

**数据操作语言 DML**(`Data Manipulation Language`)：用来**对数据库中表的数据记录进行增、删、改操作**

## 添加数据

**注意**：

1. 插入数据时，指定的字段顺序需要与值的顺序是一一对应的
2. 字符串和日期型数据应该包含在引号中
3. 插入的数据大小，应该在字段的规定范围内

### 给指定字段添加数据

使用 `INSERT INTO 表名 (字段名1, 字段名2, ...)  VALUES (值1, 值2, ...);` 给指定字段添加数据

```sql
INSERT INTO 表名 (字段名1, 字段名2, ...)  VALUES (值1, 值2, ...);
```

**例**：

```sql
INSERT INTO user(id,username) VALUES (1,'张三');
INSERT INTO user(id,username,password) VALUES (1,'张三','123');
INSERT INTO user(id,password) VALUES (1,'123');
```

![image-20230909220545880](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309092205290.png)

### 给全部字段添加值

使用 `INSERT INTO 表名 VALUES (值1, 值2, ...);` 给全部字段添加值

```sql
INSERT INTO 表名 VALUES (值1, 值2, ...);
```

**例**：

```sql
insert into user values (2,'李四','lisi');
```

![image-20230909220650705](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309092206160.png)

### 批量添加数据

#### 指定字段批量添加

使用 `INSERT INTO 表名 (字段名1, 字段名2, ...) VALUES (值1, 值2, ...), (值1, 值2, ...), (值1, 值2, ...);` 批量添加指定字段

```sql
INSERT INTO 表名 (字段名1, 字段名2, ...) VALUES (值1, 值2, ...), (值1, 值2, ...), (值1, 值2, ...);
```

**例**：

```sql
INSERT INTO user (id,username,password) VALUES (1, '张三', 'zhangsan'), (2, '李四', 'lisi'), (3, '王五','wangwu');
```

![image-20230909224554016](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309092247590.png)

#### 全部字段批量添加

使用 `INSERT INTO 表名 VALUES (值1, 值2, ...), (值1, 值2, ...), (值1, 值2, ...);` 批量添加全部字段

```sql
INSERT INTO 表名 VALUES (值1, 值2, ...), (值1, 值2, ...), (值1, 值2, ...);
```

**例**：

```sql
INSERT INTO user VALUES (1, '张三', 'zhangsan'), (2, '李四', 'lisi'), (3, '王五','wangwu');
```

![image-20230909224724383](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309092247207.png)

## 修改数据

使用 `UPDATE 表名 SET 字段名1 = 值1,字段名2 = 值2,.... [ WHERE  条件 ] ` 修改字段值

```sql
UPDATE 表名 SET 字段名1 = 值1,字段名2 = 值2,.... [ WHERE  条件 ]
```

**说明**：修改语句的where条件可以有，也可以没有，如果没有条件，则会修改整张表的所有数据。

**例**：

```sql
UPDATE user SET username = 'haha',password = '123123';
SELECT * FROM user;
UPDATE user SET username = 'zhangsan',password = 'zs' WHERE id = 1;
SELECT * FROM user;
```

![image-20230909225955723](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309092259468.png)

## 删除数据

使用 `DELETE FROM 表名 [ WHERE 条件 ] ;` 删除记录

```sql
DELETE FROM 表名 [ WHERE 条件 ] ;
```

**注意**：

1. DELETE 语句的条件可以有，也可以没有，如果没有条件，则会删除整张表的所有数据
2. DELETE 语句不能删除某一个字段的值(可以使用UPDATE，将该字段值置为NULL）

**例**：

```sql
DELETE FROM user WHERE id=1;
SELECT * FROM user;
DELETE FROM user;
SELECT * FROM user;
```

![image-20230909230305793](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309092303759.png)