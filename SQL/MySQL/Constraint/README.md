# 约束

**约束**是**作用于表中字段上**的**规则**，用于**限制存储在表中的数据**。 使用约束可以保证数据库中数据的正确、有效性以及完整性。可以在创建表或修改表的时候在表字段上添加约束。

![image-20230911234825421](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309112348169.png)

## 普通约束

在开发过程中，如果想要持久化存储数据就不可避免的需要建立相关表。而建表以后对于插入其中的数据，如果后台没有校验，数据库也没有约束的话将显得十分混乱，可以通过指定约束来规范数据。

**注意**：在一些正常情况下，**可以在一个字段上使用多个约束条件**。

### 主键约束

**注意**：每个表只能为一个字段指定主键`PRIMARY KEY`约束。

#### 建表时指定约束

在创建表时在字段类型之后加上主键约束的关键字(`PRIMARY KEY`)，并且使用 `AUTO_INCREMENT` 自增即可。

```mysql
CREATE TABLE test(
	id INT AUTO_INCREMENT PRIMARY KEY  COMMENT  'ID唯一标识',
	name VARCHAR(20) COMMENT  '姓名',
	test INT  COMMENT  '无约束对比测试字段'
);
```

![image-20230912003841054](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309120038513.png)

#### 建表后指定约束

创建没有约束的表并添加主键约束(`PRIMARY KEY`)并使用 `AUTO_INCREMENT` 自增即可。

添加**主键约束** (`primary key`)：

```mysql
ALTER TABLE 表名  ADD PRIMARY KEY(表字段名);
```

添加自增：

```mysql
ALTER TABLE 表名 MODIFY 字段名 数据类型 AUTO_INCREMENT;
```

**例**：

```mysql
CREATE TABLE test(
	id int COMMENT  'ID唯一标识',
	name VARCHAR(20) COMMENT  '姓名',
	test int  COMMENT  '无约束对比测试字段'
);
ALTER TABLE test ADD PRIMARY KEY (id);
ALTER TABLE test MODIFY id int AUTO_INCREMENT;
```

![image-20230912003955620](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309120040907.png)

#### 插入测试

```mysql
INSERT INTO test(name) VALUES ('张三');
INSERT INTO test(name) VALUES ('李四');
SELECT * FROM test;
```

![image-20230912004618851](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309121037796.png)

### 唯一约束

#### 建表时指定约束

创建表时在字段类型之后加上唯一约束的关键字(`UNIQUE`)即可。

```mysql
CREATE TABLE test(
	name VARCHAR(20) UNIQUE COMMENT  '姓名',
	test VARCHAR(20) COMMENT  '无约束对比测试字段'
);
```

![image-20230912010004463](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309120100046.png)

#### 建表后指定约束

创建没有约束的表并添加唯一约束(`UNIQUE`)即可。

添加**唯一约束** (`UNIQUE`)：

```mysql
ALTER TABLE 表名 ADD UNIQUE(表字段名);
```

**例**：

```mysql
CREATE TABLE test(
	name VARCHAR(20) COMMENT  '姓名',
	test VARCHAR(20) COMMENT  '无约束对比测试字段'
);
ALTER TABLE test ADD UNIQUE(name);
```

![image-20230912010053302](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309120100435.png)

#### 插入测试

```mysql
INSERT INTO test VALUES ('张三','张三');
INSERT INTO test VALUES ('张三','张三');
SELECT * FROM test;
```

![image-20230912010208703](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309120102074.png)

### 默认约束

**注意**：当使用`DEFAULT`约束指定默认值时，**默认值必须符合字段数据类型**。

#### 建表时指定约束

创建表时在字段类型之后加上默认约束的关键字(`DEFAULT`)即可。

```mysql
CREATE TABLE test(
	name VARCHAR(20) COMMENT  '姓名',
    status char(1) DEFAULT  '1'  COMMENT  '状态',
	test INT  COMMENT  '无约束对比测试字段'
);
```

![image-20230912105655568](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309121056960.png)

#### 建表后指定约束

创建没有约束的表并添加默认约束(`DEFAULT`)即可。

添加**默认约束** (`DEFAULT`)：

```mysql
ALTER TABLE 表名 MODIFY 字段名 数据类型 DEFAULT 默认值;
```

**例**：

```mysql
CREATE TABLE test(
	name VARCHAR(20) COMMENT  '姓名',
    status char(1) COMMENT  '状态',
	test INT  COMMENT  '无约束对比测试字段'
);
ALTER TABLE test MODIFY status int DEFAULT '1';
```

![image-20230912105755300](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309121057581.png)

#### 插入测试

```mysql
INSERT INTO test(name) VALUES ('张三');
INSERT INTO test(name,status) VALUES ('李四',2);
SELECT * FROM test;
```

![image-20230912110011594](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309121100537.png)

### 检查约束

**注意**：当使用`CHECK`约束时，约束条件必须写在`()`中。

#### 建表时指定约束

创建表时在字段类型之后加上检查约束的关键字(`CHECK`)即可。

```mysql
CREATE TABLE test(
	name VARCHAR(20) COMMENT  '姓名',
    age INT CHECK(age > 0 && age <= 120)  COMMENT  '年龄',
	test INT  COMMENT  '无约束对比测试字段'
);
```

![image-20230912111409528](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309121114720.png)

#### 建表后指定约束

创建没有约束的表并添加默认约束(`DEFAULT`)即可。

添加**检查约束**(`CHECK`)：

```sql
ALTER TABLE 表名 ADD CONSTRAINT 字段名 CHECK(约束条件);
```

**例**：

```mysql
CREATE TABLE test(
	name VARCHAR(20) COMMENT  '姓名',
    age INT COMMENT  '年龄',
	test INT COMMENT  '无约束对比测试字段'
);
ALTER TABLE test ADD CONSTRAINT age CHECK(age > 0 && age <= 120);
```

![image-20230912111637041](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309121116577.png)

#### 插入测试

```mysql
INSERT INTO test(name,age,test) VALUES ('张三',29,29);
INSERT INTO test(name,age,test) VALUES ('李四',150,150);
SELECT * FROM test;
```

![image-20230912112039870](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309121120126.png)

### 非空约束

#### 建表时指定约束

创建表时在字段类型之后加上非空约束的关键字(` NOT NULL`)即可。

```mysql
CREATE TABLE test(
	name VARCHAR(20)  NOT NULL COMMENT  '姓名' ,
	test VARCHAR(20)  COMMENT  '无约束对比测试字段'
);
```

![image-20230912112809037](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309121128171.png)

#### 建表后指定约束

创建没有约束的表并添加非空约束(` NOT NULL`)即可。

添加**非空约束**(` NOT NULL`)：

```sql
ALTER TABLE 表名 MODIFY 字段名 数据类型  NOT NULL
```

**例**：

```mysql
CREATE TABLE test(
	name VARCHAR(20) COMMENT  '姓名' ,
	test VARCHAR(20)  COMMENT  '无约束对比测试字段'
);
ALTER TABLE test MODIFY name VARCHAR(20) NOT NULL;
```

![image-20230912112857455](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309121128848.png)

#### 插入测试

```mysql
INSERT INTO test(name,test) VALUES (null,null);
INSERT INTO test(name,test) VALUES ('张三','张三');
SELECT * FROM test;
```

![image-20230912113015276](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309121130508.png)

## 外键约束

外键约束通过作用于两张表之间，用于相互约束彼此的行为，从而保证数据的一致性和完整性。

**说明**：实际开发时，一般在开发过程中，不给数据库表设置外键约束。
**原因**：避免调试不方便。一般是功能开发完成，再加外键约束检查是否有bug。

**例**：

左侧的emp表是员工表，里面存储员工的基本信息，包含员工的ID、姓名、年龄、职位、薪资、入职日期、上级主管ID、部门ID，在员工的信息中存储的是部门的ID dept_id，而这个部门的ID是关联的 部门表dept的主键id，emp表的dept_id就是外键,关联的是另一张dept表的主键。

![image-20230912144737805](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309121858265.png)

两张表之间存在着一种关联关系，但它们只是在逻辑上存在这样一层关系；在数据库层面，并未建立外键关联。也就说emp表中的dept_id值可以为任意数值，即是dept表中不存在。而dept表中字段被emp使用了也可以随意删除。 因此无法保证数据的一致性和完整性的。这时候就需要严格的进行手动维护或者使用外键约束。

### 添加外键

**说明**：

- 添加外键时必须得确保需要关联的父表已经创建
- 一个表可存在多个外键，且可以关联多个表

#### 建表时添加

使用 `CREATE TABLE 表名( 字段名    数据类型, ... [CONSTRAINT] [外键名称]  FOREIGN  KEY (子表字段名)   REFERENCES   父表 (父表字段名) );` 添加外键

```mysql
CREATE TABLE 表名(
字段名    数据类型,
 ...
 [CONSTRAINT] [外键名称]  FOREIGN  KEY (子表字段名)   REFERENCES   父表 (父表字段名)
);
```

**例**：

```mysql
CREATE TABLE dept(
	id INT AUTO_INCREMENT PRIMARY KEY COMMENT '部门 ID',
	name VARCHAR(50) COMMENT '部门名称'
) COMMENT '部门表';

# 必须先创建需要关联的父表 (dept)
CREATE TABLE emp(
 id  INT auto_increment COMMENT 'ID' primary key,
 name VARCHAR(50) NOT NULL COMMENT '姓名',
 age  INT COMMENT '年龄',
 job VARCHAR(20) COMMENT '职位',
 salary INT COMMENT '薪资',
 entrydate DATE COMMENT '入职时间',
 managerid INT COMMENT '直属领导ID',
 dept_id INT COMMENT '部门ID',
 CONSTRAINT fk_dept_id FOREIGN  KEY (dept_id) REFERENCES dept(id)
)COMMENT '员工表';
```

![image-20230912150021819](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309121502312.png)

![image-20230912150205212](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309121502081.png)

#### 建表后添加

使用 `ALTER TABLE 表名 ADD CONSTRAINT 外键名称 FOREIGN KEY (子表字段名) REFERENCES 父表 (父表字段名);`　添加外键

```mysql
ALTER TABLE 表名 ADD CONSTRAINT 外键名称 FOREIGN KEY (子表字段名) REFERENCES 父表 (父表字段名);
```

**例**：

```mysql
CREATE TABLE dept(
	id INT AUTO_INCREMENT PRIMARY KEY COMMENT '部门 ID',
	name VARCHAR(50) COMMENT '部门名称'
) COMMENT '部门表';

# 必须先创建需要关联的父表 (dept)
CREATE TABLE emp(
 	id  INT auto_increment COMMENT 'ID' primary key,
 	name VARCHAR(50) NOT NULL COMMENT '姓名',
	 age  INT COMMENT '年龄',
	 job VARCHAR(20) COMMENT '职位',
	 salary INT COMMENT '薪资',
 	entrydate DATE COMMENT '入职时间',
 	managerid INT COMMENT '直属领导ID',
 	dept_id INT COMMENT '部门ID'
)COMMENT '员工表';
ALTER TABLE emp ADD CONSTRAINT fk_dept_id FOREIGN KEY (dept_id) REFERENCES dept(id);
```

![image-20230912150808431](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309121509157.png)

![image-20230912150934426](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309121509907.png)

#### 外键测试

添加外键约束后无法随意删除父表中的数据，必须先删除所有子表中关联到改记录的数据才能删除父表中数据。

```mysql
# emp中使用了该记录无法直接删除dept表中的记录
DELETE FROM dept WHERE id = 1;
# 必须先删除emp表的关联数据
DELETE FROM emp WHERE dept_id = 1;
# 然后才能删除成功dept表中的数据
DELETE FROM dept WHERE id = 1;
```

![image-20230912152116879](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309121521470.png)

### 删除外键

使用 `ALTER TABLE  表名   DROP  FOREIGN  KEY  外键名称;` 删除外键

```mysql
ALTER TABLE  表名   DROP  FOREIGN  KEY  外键名称;
```

![image-20230912152326971](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309121530518.png)

![image-20230912153054919](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309121530497.png)

### 删除/更新行为

在添加了外键之后，再删除**父表数据**时产生的约束行为，就称为删除/更新行为。具体的删除/更新行为有以下几种:

![image-20230912154450928](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309121544333.png)

**注意**：`NO ACTION`与`RESTRICT`为外键约束的默认行为，也就是在一些情况下阻止删除/更新数据，添加外键时默认生效。如果需要修改为其他几种行为则需要在添加外键时手动设置。

**修改删除/更新语法**：

```mysql
ALTER TABLE  表名  ADD CONSTRAINT  外键名称  FOREIGN KEY  (外键字段)   REFERENCES   
父表名 (父表字段名)  ON UPDATE [更新行为] ON DELETE [删除行为]
```

**例**：

- `CASCADE`行为：

  ```mysql
  # 1.修改更新/删除行为同步
  ALTER TABLE  emp  ADD CONSTRAINT  fk_emp_dept_id  FOREIGN KEY  (dept_id) REFERENCES dept (id)  
    ON UPDATE CASCADE ON DELETE CASCADE;
  # 2.修改父表id值
  UPDATE dept SET id = 999 WHERE name = '研发部';
  # 3.父表成功修改
  SELECT * FROM dept;
  # 4.子表自动更新外键值
  SELECT * FROM emp;
  
  # 1.测试删除行为
  DELETE FROM dept WHERE id = 999;
  # 2.成功同步删除
  SELECT * FROM dept;
  ```

  ![image-20230912184640377](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309121858531.png)
  ![image-20230912184405708](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309121846480.png)

- `SET NULL`行为：

  ```mysql
  # 1.修改更新/删除行为同步
  ALTER TABLE  emp  ADD CONSTRAINT  fk_emp_dept_id  FOREIGN KEY  (dept_id) REFERENCES dept (id)  
    ON UPDATE SET NULL ON DELETE SET NULL;
  # 2.修改父表id值
  UPDATE dept SET id = 999 WHERE name = '总经办';
  # 3.自动变为null
  SELECT * FROM emp;
  # 4.修改成功
  SELECT * FROM dept;
  
  # 1.测试删除行为
  DELETE FROM dept WHERE id = 999;
  # 2.成功同步删除
  SELECT * FROM emp;
  ```

  ![image-20230912185431478](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309122124233.png)

![image-20230912185755099](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309121858203.png)