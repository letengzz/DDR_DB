# 数据定义语言 DDL

**数据定义语言 DDL**(`Data Definition Language`)：用来**定义数据库对象(数据库，表，字段)**

## 数据库操作

### 创建操作

使用 `CREATE DATABASE [ IF NOT EXISTS ] 数据库名 [ DEFAULT CHARSET 字符集 ] [ COLLATE 排序`
`规则 ];` 创建数据库

```sql
create database [ IF NOT EXISTS ] 数据库名 [ DEFAULT CHARSET 字符集 ] [ COLLATE  排序规则 ];
```

- 当添加 `IF NOT EXISTS` 后，若不存在该数据库则创建，否则不创建
- 当添加 `DEFAULT CHARSET 字符集` 后可指定字符编码
- 当添加 `COLLATE 排序规则` 后，可指定字符编码

**例**：

```sql
CREATE DATABASE sql_test;

CREATE DATABASE IF NOT EXISTS sql_test;

CREATE DATABASE sql_test2 DEFAULT CHARSET utf8mb4;
```

![image-20230909131717436](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309091320037.png)

### 删除操作

使用 `DROP DATABASE [ if exists ] 数据库名;` 删除数据库

```sql
DROP DATABASE [ IF EXISTS ] 数据库名;
```

- 当添加 `IF EXISTS` 后，若存在该数据库则删除，否则不删除

**例**：

```sql
DROP DATABASE sql_test;

DROP DATABASE IF EXISTS sql_test;
```

![image-20230909132449917](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309091333275.png)

### 查询操作

#### 查询所有数据库

使用 `SHOW DATABASES;` 查询所有数据库

```sql
SHOW DATABASES;
```

![image-20230909133342414](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309091333114.png)

#### 查询当前所在数据库

使用 `SELECT DATABASE();` 查询当前所在数据库 (若之前未选择数据库则为null)

```sql
SELECT DATABASE();
```

![image-20230909133526432](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309091335571.png)

### 切换数据库

使用 `use 数据库名;` 切换数据库

```sql
use 数据库名;
```

**说明**：当操作某一个数据库下的表时，就需要切换到对应的数据库下，否则是不能操作的

**例**：

```sql
CREATE DATABASE sql_test;

SELECT DATABASE();

use sql_test;

SELECT DATABASE();
```

![image-20230909132840515](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309091351948.png)

## 表操作

### 创建表操作

#### 创建表结构

使用 `CREATE TABLE  表名(字段1  字段1类型 [COMMENT  '字段1注释'], ... ,字段n  字段n类型 [COMMENT  '字段n注释' ] ) [ COMMENT  '表注释' ] ;` 创建表结构

```sql
CREATE TABLE  表名(
字段1  字段1类型 [COMMENT  '字段1注释' ],
字段2  字段2类型 [COMMENT  '字段2注释' ],
字段3  字段3类型 [COMMENT  '字段3注释' ],
 ......
字段n  字段n类型 [COMMENT  '字段n注释' ] 
) [ COMMENT  '表注释' ] ;
```

**注意**：

- 创建表之前需要使用 `use 数据库名` 切换到对应的数据库
- 最后一个字段后面没有逗号

**例**：

```sql
use sql_test;

CREATE TABLE user(
  id int COMMENT '编号',
  username varchar(50) COMMENT '用户名',
  password varchar(50) COMMENT '密码'
) COMMENT '账号密码表';
```

![image-20230909134537805](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309091347154.png)

#### 添加字段

使用 `ALTER TABLE 表名 ADD  字段名  类型 (长度)  [ COMMENT 注释 ]  [ 约束 ];` 添加字段

```sql
ALTER TABLE 表名 ADD  字段名  类型 (长度)  [ COMMENT 注释 ]  [ 约束 ];
```

**例**：

```sql
DESC user;

ALTER TABLE user ADD vip int COMMENT '是否为VIP用户';

DESC user;
```

![image-20230909140703580](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309091407929.png)

### 查询表操作

#### 查询当前数据库所有表

使用 `SHOW TABLES;` 查询当前数据库所有表

```sql
SHOW TABLES;
```

**例**：

```sql
use sql_test;

SHOW TABLES;
```

![image-20230909141542108](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309091415598.png)

#### 查询指定表结构

使用 `desc 表名;`  查看指定表结构

```sql
desc 表名;
```

**说明**： 可以查看到指定表的字段，字段的类型、是否可以为NULL，是否存在默认值等信息。

**例**：

```sql
DESC user;
```

![image-20230909141723195](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309091417299.png)

#### 查询指定表的建表语句

使用 `SHOW CREATE TABLE 表名;` 查询指定表的建表语句

```sql
SHOW CREATE TABLE 表名;
```

**说明**：可以用来查看建表语句的SQL，其中部分参数在创建表的时候，并未指定也会查询到，因为这部分是数据库的默认值，如：存储引擎、字符集等。

**例**：

```sql
SHOW CREATE TABLE user;
```

![image-20230909141917499](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309091419964.png)

### 修改表操作

#### 修改字段数据类型

使用 `ALTER TABLE 表名 MODIFY  字段名  新数据类型 (长度);` 修改字段数据类型

```sql
ALTER TABLE 表名 MODIFY  字段名  新数据类型 (长度);
```

**例**:

```sql
DESC user;

ALTER TABLE user MODIFY vip varchar(20);

DESC user;
```

![image-20230909142412877](./assets/image-20230909142412877.png)

#### 同时修改字段名和字段类型

使用 `ALTER TABLE 表名 CHANGE  旧字段名  新字段名  类型 (长度)  [ COMMENT 注释 ]  [ 约束 ];` 同时修改字段名和字段类型

```sql
ALTER TABLE 表名 CHANGE  旧字段名  新字段名  类型 (长度)  [ COMMENT 注释 ]  [ 约束 ];
```

**例**：

```sql
DESC user;

ALTER TABLE user CHANGE vip isVip int;

DESC user;
```

![image-20230909143355126](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309091433284.png)

#### 修改表名

使用 `ALTER TABLE 表名 RENAME TO  新表名;` 修改表名

```sql
ALTER TABLE 表名 RENAME TO  新表名;
```

**例**：

```sql
SHOW TABLES;

ALTER TABLE user RENAME TO new_user;

SHOW TABLES;
```

![image-20230909143719664](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309091437287.png)

### 删除表操作

#### 删除字段

使用 `ALTER TABLE 表名 DROP  字段名;` 删除字段

```sql
ALTER TABLE 表名 DROP  字段名;
```

**例**：

```sql
DESC new_user;

ALTER TABLE new_user DROP isVip;

DESC new_user;
```

![image-20230909143959305](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309091440937.png)

#### 删除表

使用 `DROP  TABLE [ IF  EXISTS ]  表名;` 删除表

```sql
DROP  TABLE [ IF  EXISTS ]  表名;
```

- 当添加 `IF EXISTS` 后，若存在该数据表则删除，否则不删除

**注意**：在删除表的时候，表中的全部数据也都会被删除。

**例**：

```sql
SHOW TABLES;

DROP TABLE IF EXISTS new_user;

SHOW TABLES;
```

![image-20230909144414867](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309091444620.png)

#### 删除指定表，并重新创建表

使用 `TRUNCATE  TABLE 表名;` 删除指定表，并重新创建表

```sql
TRUNCATE  TABLE 表名;
```

**例**：

```sql
SELECT * FROM user;

TRUNCATE TABLE user;

SELECT * FROM user;
```

![image-20230910163814647](./assets/image-20230910163814647.png)
