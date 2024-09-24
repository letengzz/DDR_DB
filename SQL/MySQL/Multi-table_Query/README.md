# 多表关系

在项目开发中，在进行数据库表结构设计时，会根据业务需求及业务模块之间的关系，分析并设计表结构，由于业务之间经常会存在相互关联关系，所以由此设计出的各个表结构之间也存在着各种联系，基本上分为三种：

- 一对多 (多对一)

- 多对多
- 一对一

## 一对多

业务示例：部门与员工的关系

关系介绍：一个部门对应多个员工，一个员工对应一个部门

实现方式：**通常会在 '多' 的一方建立外键，指向 '一' 的一方的主键**

![image-20230913125410187](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309131524346.png)

## 多对多

业务示例：学生与课程的关系
关系介绍：一个学生可以选修多门课程，一门课程也可以供多个学生选择
实现方式：**建立第三张中间表，中间表至少包含两个外键，分别关联两方主键**

![image-20230913145919870](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309131500098.png)

## 一对一

业务示例：用户与用户详情的关系
关系介绍：一对一关系，多用于单表拆分，将一张表的基础字段放在一张表中，其他详情字段放在另 一张表中，以提升操作效率
实现方式：**在任意一方加入外键，关联另外一方的主键，并且设置外键为唯一的 (UNIQUE)**

![image-20230913152356166](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309131633356.png)

# 多表查询

多表查询就是指一次性从多张表中查询数据。

**查询单表数据**：执行的SQL形式为：`select 字段列表 from 表名;`

```mysql
SELECT 字段列表 FROM 表名;
```

**多表查询**：就只需要使用逗号分隔多张表即可，如： `select 字段列表 from 表名1, 表名2;`

```mysql
SELECT 字段列表 FROM 表名1, 表名2;
```

**问题**：同时查到了多张表的数据，但是数据形式排列组合了两张表中的所有数据项

![image-20230913153717956](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309131633119.png)

**例**：查询员工、部门表，本来预期是每个员工对应其所在的部门，但事实确实，每个员工都对应了所有部门。这种现象也称之为 **笛卡尔积** 

![image-20230913155833752](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309131558077.png)


因此，在多表查询中，需要根据业务情况进行连接查询，消除无效的笛卡尔积，只保留两张表关联部分的有效数据。

可以通过`表名.字段名`指定员工表的外键等于部门表的主键即可获得预期数据

![image-20230913160247056](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309131602344.png)

**说明**：

- 不光可以为字段起别名，同样可以使用相同的语法给表起别名，`table as 别名或table 别名`

  一旦为表起了别名，就不能再使用表名来指定对应的字段了，此时只能够使用别名来指定字段

- 在获取表字段时，可以使用`表名.字段名`来进行指定。

## 内连接

内连接查询的是两张表交集部分的数据。

![image-20230913161710799](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309131617329.png)

语法分为：

- 隐式内连接
- 显式内连接

### 隐式内连接

**基本语法**：

```mysql
SELECT 字段列表 FROM 表1,表2 WHERE 限制条件;
```

**例**：

查询每一个员工的姓名 , 及关联的部门的名称 

```mysql
SELECT e.name,d.name FROM emp e,dept d WHERE e.dept_id = d.id;
```

![image-20230913162938159](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309131633718.png)

### 显式外连接

**基本语法**：

```mysql
SELECT 字段列表 FROM 表1 [ INNER ] JOIN 表2 ON 连接条件 ... ;
```

**例**：

查询每一个员工的姓名 , 及关联的部门的名称 

```mysql
SELECT e.name, d.name FROM emp e INNER JOIN dept d ON e.dept_id = d.id;
```

![image-20230913163243902](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309131632236.png)

## 外连接

外连接分为：

- 左外连接：左外连接相当于查询表1(左表)的所有数据，当然也包含表1和表2交集部分的数据
- 右外连接：右外连接相当于查询表2(右表)的所有数据，当然也包含表1和表2交集部分的数据

![image-20230913163741488](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309131804712.png)

### 左外连接

**基本语法**：

```mysql
SELECT 字段列表 FROM 表1 LEFT [ OUTER ] JOIN 表2 ON 条件 ... ;
```

**例**：

查询emp表的所有数据, 和对应的部门信息

```mysql
SELECT e.*, d.name FROM emp e LEFT OUTER JOIN dept d ON e.dept_id = d.id;
```

**说明**：内连接则无法查询到null，因为外连接会获取到一张表的全部数据，而内连接只获取交集部分数据。

![image-20230913164514558](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309131817046.png)

### 右外连接

**基本语法**：

```mysql
SELECT 字段列表 FROM 表1 RIGHT [ OUTER ] JOIN 表2 ON 条件 ... ;
```

**例**：

查询emp表的所有数据, 和对应的部门信息 

```mysql
SELECT e.*, d.name FROM emp e RIGHT OUTER JOIN dept d ON e.dept_id = d.id;
```

**说明**：通常左外连接和右外连接是可以相互替换的，只需要调整在连接查询时SQL中，表结构的先后顺序就可以了。**在日常开发使用时，更偏向于左外连接。**

![image-20230913164904980](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309131817420.png)

## 自连接

自连接查询，顾名思义，就是自己连接自己，也就是把一张表进行连接查询多次。

**注意**：在自连接查询中，必须要为表起别名，要不然不清楚所指定的条件、返回的字段，到底是哪一张表的字段。

自连接查询，可以是[内连接查询](#内连接)，也可以是[外连接查询](#外连接)，其关键点在于 自己连接自己

```mysql
SELECT 字段列表 FROM 表A 别名A JOIN 表A 别名B ON 条件 ... ;
```

**例**：

查询员工 及其所属领导的名字，如果员工没有领导，也需要查询出来

```mysql
SELECT a.name '员工', b.name '领导' FROM emp a LEFT JOIN emp b ON a.managerid = b.id;
```

![image-20230913171538946](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309131715228.png)

## 联合查询

对于联合查询，就是把多次查询的结果合并起来，形成一个新的查询结果集。

**基本语法**：

```mysql
SELECT 字段列表 FROM 表A  ...   # 查询结果集1
UNION [ ALL ]
SELECT 字段列表 FROM 表B  ....;  # 查询结果集2
```

**注意**：

- 对于联合查询的多张表的字段列表必须保持一致，字段类型也需要保持一致，如果不一致将会报错。


- UNION ALL 会将全部的数据直接合并在一起，union 会对合并之后的数据去重。

**例**：

```mysql
SELECT * FROM emp WHERE salary < 5000
UNION ALL
SELECT * FROM emp WHERE age > 30;
```

UNION ALL 查询出来的结果，仅仅只对数据集进行简单的合并，查询结果中可能会存在重复数据项，使用UNION 即可去除重复数据项。

![image-20230913172651072](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309131727306.png)

## 子查询

SQL语句中嵌套SELECT语句，称为**嵌套查询**，又称**子查询**。

**说明**：子查询外部的语句可以是 INSERT / UPDATE / DELETE / SELECT 的任何一个。嵌套SELECT语句可以位于SELECT之后、FROM之后、WHERE之后。

子查询根据结果不同，分为：

- 标量子查询 (子查询结果为单个值)
- 列子查询 (子查询结果为一列)
- 行子查询 (子查询结果为一行)
- 表子查询 (子查询结果为多行多列)

**例**：

```mysql
SELECT * FROM t1 WHERE column1 = (SELECT column1 FROM t2); 
```

### 标量子查询

子查询返回的结果是单个值（例如数字、字符串、日期等）。 常用的操作符有：`=`、`<>`、`>` 、`>=`、`<`、`<=`

**例**：查询 "研发部" 的所有员工信息

- 拆分1： 查询 "研发部" 部门ID，返回单个id值

  ```mysql
  select id from dept where name = '研发部';
  ```

- 拆分2：根据部门ID, 查询员工信息

  ```mysql
  select id from dept where name = xxx;
  ```

- 完整版

  ```mysql
  select * from emp where dept_id = (select id from dept where name = '研发部');
  ```

![image-20230913173535416](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309131804359.png)

### 列子查询

子查询返回的结果是一列（可以是多行）。常用的操作符：`IN` 、`NOT IN` 、 `ANY` 、`SOME` 、 `ALL`

**例**：查询比 市场部 所有人工资都高的员工信息

- 拆分1: 查询市场部id：

  ```mysql
  select id from dept where name = '市场部';
  ```

- 拆分2： 查询市场部员工工资

  ```mysql
  select salary from emp where dept_id = 拆分1;
  select salary from emp where dept_id = (select id from dept where name = '市场部');
  ```

- 拆分3 ： 比 市场部 所有人工资都高的员工信息

  ```mysql
  select * from emp where salary > all (拆分2);
  ```

- 合并

  ```mysql
  select * from emp where salary > all ( select salary from emp where dept_id = 
  (select id from dept where name = '市场部') );
  ```

![image-20230913181308713](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309131813277.png)

![image-20230913181400591](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309131816696.png)

### 行子查询

子查询返回的结果是一行（可以是多列）。常用的操作符：`=` 、`<>` 、`IN` 、`NOT IN`

**例**：查询与 “张无忌” 的薪资及直属领导相同的员工信息

- 拆分1：查询 "张无忌" 的薪资及直属领导

  ```mysql
  select salary, managerid from emp where name = '张无忌';
  ```

- 拆分2：查询与 "张无忌" 的薪资及直属领导相同的员工信息

  ```mysql
  select * from emp where (salary,managerid) = (xx,xx);
  ```

- 合并：

  ```mysql
  select * from emp where (salary,managerid) = (select salary, managerid from emp 
  where name = '张无忌');
  ```

![image-20230913175139373](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309131752376.png)

![image-20230913175237011](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309131753160.png)

### 表子查询

子查询返回的结果是多行多列。常用的操作符：`IN`

**例**：查询与 "鹿杖客" , "宋远桥" 的职位和薪资相同的员工信息

- 拆分1：查询 "鹿杖客" , "宋远桥" 的职位和薪资

  ```mysql
  select job, salary from emp where name = '鹿杖客' or name = '宋远桥';
  ```

- 拆分2：查询与 "鹿杖客" , "宋远桥" 的职位和薪资相同的员工信息

  ```mysql
  select * from emp where (job,salary) in ( xxx );
  ```

- 合并

  ```mysql
  select * from emp where (job,salary) in (select job, salary from emp where name = '鹿杖客' or name = '宋远桥');
  ```

![image-20230913180030595](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309131814822.png)

![image-20230913180129006](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309131814738.png)