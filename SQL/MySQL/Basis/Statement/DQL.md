# 数据查询语言 DQL

**数据查询语言 DQL**(`Data Query Language`)：用来**查询数据库中表的记录**。

## 基础查询

### 查询指定字段

使用 `SELECT 字段1, 字段2, 字段3 ...  FROM   表名;` 查询指定字段

```sql
SELECT 字段1, 字段2, 字段3 ...  FROM   表名;
```

**例**：

```sql
SELECT id,username FROM user;
SELECT id,username,password FROM user;
```

![image-20230910171926521](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309111525483.png)

### 查询全部字段

使用 `SELECT  *  FROM  表名;` 查询全部字段(`*` 号代表所有字段)

```sql
SELECT  *  FROM  表名;
```

**例**：

```sql
SELECT  *  FROM  user;
```

![image-20230910171951705](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309111525917.png)

### 查询时为字段设置别名

**使用as设置别名**：

```sql
SELECT 字段1 [ AS 别名1 ],字段2 [ AS 别名2 ] ...  FROM 表名;
```

**使用空格设置别名**：

```sql
SELECT 字段1 [ 别名1 ],字段2 [ 别名2 ] ...  FROM 表名;
```

**例**：

```sql
SELECT id,username AS 账号,password AS 密码 FROM user;
SELECT id,username 账号,password 密码 FROM user;
```

![image-20230910172222955](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309111525806.png)

### 去除重复记录查询

使用 `SELECT  DISTINCT  字段1,字段2...  FROM 表名;` 去除重复记录查询

```sql
SELECT  DISTINCT  字段1,字段2...  FROM 表名;
```

**例**：

```sql
SELECT  * FROM user;
SELECT  DISTINCT  username,password  FROM user;
SELECT  DISTINCT  username FROM user;
```

![image-20230910172530105](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309111525547.png)

## 条件查询

使用 `SELECT 字段列表 FROM 表名 WHERE 条件列表;` 来进行条件查询

- [常用条件](common_condition.md)

```sql
SELECT 字段列表 FROM 表名 WHERE 条件列表;
```

**例**：

- 查询年龄等于 88 的员工：

  ```mysql
  SELECT * FROM emp WHERE age = 88;
  ```

  ![image-20230911150112334](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309111525760.png)

- 查询年龄不等于 88 的员工：

  ```mysql
  SELECT * FROM emp WHERE age != 88;
  SELECT * FROM emp WHERE age <> 88;
  ```

  ![image-20230911150306048](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309111525070.png)

- 查询没有身份证号的员工信息：

  ```mysql
  SELECT * FROM emp WHERE idcard IS NULL;
  ```

  ![image-20230911150555298](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309111525618.png)

- 查询有身份证号的员工信息：

  ```mysql
  SELECT * FROM emp WHERE idcard IS NOT NULL;
  ```

  ![image-20230911150632995](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309111525411.png)

- 查询年龄在15岁(包含) 到 20岁(包含)之间的员工信息：

  ```mysql
  SELECT * FROM emp WHERE age >= 15 AND age <= 20;
  SELECT * FROM emp WHERE age >= 15 && age <= 20;
  SELECT * FROM emp WHERE age BETWEEN 15 AND 20;
  ```

  ![image-20230911150723584](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309111525190.png)

- 查询年龄等于18 或 20 或 40 的员工信息：

  ```mysql
  SELECT * FROM emp WHERE age = 18 OR age = 20 OR age = 40;
  SELECT * FROM emp WHERE age IN (18,20,40);
  ```

  ![image-20230911150830031](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309111525753.png)

- 查询姓范名字为两个字的员工信息：

  ```mysql
  SELECT * FROM emp WHERE name LIKE '范_';  # 名字只可以为范X
  ```

  ![image-20230911150913030](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309111525194.png)

- 查询姓范员工信息：

  ```mysql
  SELECT * FROM emp WHERE name LIKE '范%';  # 名字可以为范X,范XX,范XXX等等
  ```

  ![image-20230911150926993](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309111526054.png)

## 聚合函数查询

将一列数据作为一个整体，进行纵向计算

使用 `SELECT 聚合函数(字段列表) FROM 表名;` 来进行聚合函数查询

```mysql
SELECT 聚合函数(字段列表) FROM 表名;
```

**说明**：

- NULL值不参与所有聚合函数运算

- 使用 `count(*)` 统计总记录数

  使用 `count(指定字段)` 统计指定字段不为NULL的记录数

**常见聚合函数**：

![image-20230911152454533](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309111524031.png)

- [常见函数](../../Common_Function/README.md)

**例**：

- 统计该企业员工数量：

  ```mysql
  SELECT COUNT(*) FROM emp; -- 统计的是总记录数
  SELECT COUNT(idcard) FROM emp; -- 统计的是idcard字段不为null的记录数
  ```

  ![image-20230911152955984](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309111529528.png)

- 统计该企业员工的平均年龄：

  ```mysql
  SELECT AVG(age) FROM emp;
  ```

  ![image-20230911153016223](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309111530464.png)

- 统计该企业员工的最大年龄：

  ```mysql
  SELECT MAX(age) FROM emp;
  ```

  ![image-20230911153030753](./assets/image-20230911153030753.png)

- 统计该企业员工的最小年龄：

  ```mysql
  SELECT MIN(age) FROM emp;
  ```

  ![image-20230911153048160](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309111530643.png)

- 统计西安地区员工的年龄之和：

  ```mysql
  SELECT SUM(age) FROM emp WHERE workaddress = '西安';
  ```

  ![image-20230911153112944](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309111531403.png)

## 分组查询

使用 `SELECT 字段列表 FROM 表名 [ WHERE 条件 ] GROUP BY 分组字段名 [ HAVING 分组后过滤条件 ];` 来进行分组查询

```sql
SELECT 字段列表 FROM 表名 [ WHERE 条件 ] GROUP BY 分组字段名 [ HAVING 分组后过滤条件 ];
```

**WHERE与HAVING区别**：

- 执行时机不同：where是分组之前进行过滤；having是分组之后对结果进行过滤。
- 判断条件不同：where不能对聚合函数进行判断，而having可以。执行顺序：where > 聚合函数 > having。
- 支持多字段分组，具体语法为 : `group by 分组字段名1,分组字段名2`

**例**：

- 根据性别分组，统计男性员工 和 女性员工的数量：

  ```mysql
  SELECT gender,COUNT(*) FROM emp GROUP BY gender;
  ```

  ![image-20230911153857336](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309111539744.png)

- 查询年龄小于45的员工，并根据工作地址分组，获取员工数量大于等于3的工作地址：

  ```mysql
  SELECT workaddress,COUNT(*) address_count FROM emp WHERE age < 45 GROUP BY workaddress HAVING address_count >= 3;
  ```
  
  ![image-20230911153910841](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309111539402.png)
  
- 统计各个工作地址上班的男性及女性员工的数量：

  ```mysql
  SELECT workaddress,gender,COUNT(*) '数量' FROM emp GROUP BY gender,workaddress;
  ```

  ![image-20230911154024890](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309122129558.png)

## 排序查询

使用 `SELECT 字段列表 FROM 表名 ORDER BY 字段1 排序方式,字段2 排序方式;`进行排序查询

```mysql
SELECT 字段列表 FROM 表名 ORDER BY 字段1 排序方式,字段2 排序方式;
```

**排序方式类别**：

- ASC：升序(默认值)
- DESC：降序

**注意**：

- 如果是升序, 可以不指定排序方式 (ASC)
- 如果是多字段排序，当第一个字段值相同时，才会根据第二个字段进行排序

**例**：

- 根据年龄对公司的员工进行升序排序：

  ```mysql
  SELECT * FROM emp ORDER BY age ASC;
  SELECT * FROM emp ORDER BY age;
  ```

  ![image-20230911154216609](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309111542852.png)

- 根据年龄对公司的员工进行升序排序 , 年龄相同 , 再按照入职时间进行降序排序：

  ```mysql
  SELECT * FROM emp ORDER BY age ASC,entrydate DESC;
  ```

  ![image-20230911154535765](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309111545211.png)

## 分页查询

使用 `SELECT 字段列表 FROM 表名 LIMIT 起始索引,查询记录数;`来进行分页查询

```mysql
SELECT 字段列表 FROM 表名 LIMIT 起始索引,查询记录数;
```

**注意**：

- 起始索引从0开始，计算规则为：（查询页码 - 1）* 每页显示记录数
- 如果查询的是第一页数据，起始索引可以省略，直接简写为 `limit 10`

**例**：

- 查询第1页员工数据, 每页展示5条记录：

  ```mysql
  SELECT * FROM emp LIMIT 0,5;
  SELECT * FROM emp LIMIT 5;
  ```

  ![image-20230911154752074](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309122129453.png)

- 查询第2页员工数据, 每页展示10条记录：

  ```mysql
  SELECT * FROM emp LIMIT 5,5;
  ```

  ![image-20230911154817367](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309111549517.png)

## 复合查询

### 书写顺序

同时使用上述多种查询时必须严格遵循以下顺序书写：

```mysql
SELECT
    字段列表
FROM
    表名列表
WHERE
    条件列表
GROUP BY
    分组字段列表
HAVING
    分组后条件列表
ORDER BY
    排序字段列表
LIMIT
    分页参数
```

![image-20230911160839756](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309111608221.png)

### 系统执行顺序

DQL语句复合使用系统执行顺序为： from ... where ... group by ... having ... select ... order by ... limit ...

关于having、group by以及聚合函数的执行顺序问题，整个执行顺序：

- 先执行from语句（表之间的笛卡尔积、交并差等），获得一个虚拟表
  - 如果where语句存在，从虚拟表中筛出符合where条件的数据，不满足的被剔除
  - 如果group by语句存在，则目前存活的数据分组；如果不存在group by，则将这些数据视为一个组
  - 如果存在having语句，则将满足having条件的组留下，不满足的组被剔除
- 执行select语句：对存活下来的每个组分别执行聚合函数，形成查询结果
- 执行order by 语句：对剩下的数据进行排序
- 执行limit 语句：限制返回的数据条数