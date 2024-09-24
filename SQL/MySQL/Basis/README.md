# SQL 基础

## 书写规则

- SQL语句可以单行或多行书写，**以分号结尾**。
- MySQL数据库的SQL语句**不区分大小写，关键字建议使用大写**。
- 在同一个数据库服务器中，**不能创建两个名称相同的数据库，否则将会报错**。
- **如果删除一个不存在的数据库，将会报错。**
- 注释：
  - 单行注释：`-- 注释内容` 或 `# 注释内容`
  - 多行注释：`/* 注释内容 */`

## 数据类型

在指定字段的数据类型时，用到了int ，varchar。除此之外,MySQL中还有许多的其他数据类型，它们主要分为三类：**数值类型**、**字符串类型**、**日期时间类型**。

### 数值类型

**注意**：`DECIMAL`中**M(精度)表示整个数值长度，D(标度)表示小数位长度**。例如：123.45。M=5,D=2。

![image-20230909210942414](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309092109519.png)

### 字符串类型

**说明**：

- 使用时通常会在类型后面加上`()`表示占用空间

- CHAR 与 VARCHAR 都可以描述字符串，CHAR 是定长字符串，指定长度多长，就占用多少个字符，和 字段值的长度无关 。而VARCHAR 是变长字符串，指定的长度为最大占用长度 。

  相对来说，CHAR 的性能会更高些，而varchar相对更节省存储空间。

![image-20230909211120960](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309092111809.png)

### 日期时间类型

![image-20230909150546272](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309091505145.png)

## SQL语句

SQL语句，根据其功能，主要分为四类：`DDL`、`DML`、`DQL`、`DCL`：

![image-20230909211225965](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309092112787.png)

- [数据定义语言 DDL](Statement/DDL.md)
- [数据操作语言 DML](Statement/DML.md)
- [数据查询语言 DQL](Statement/DQL.md)
- [数据控制语言 DCL](Statement/DCL.md)



