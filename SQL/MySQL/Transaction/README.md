# 事务

事务，指的是**一组操作的集合**，它是**一个不可分割的工作单位**，它会把这个集合中**所有的操作作为一个整体一起向系统提交或撤销操作请求**，即这些操作**要么同时成功，要么同时失败**。

事务常常用于在需要操作多条记录或多张表的情况下，为了避免在执行过程中出现异常行为导致数据一致性被破坏，这时候就需要开启事务。

**例**：最经典的银行转账问题：张三给李四转账1000块钱，张三银行账户的余额减少1000，而李四银行账户的余额要增加 1000。 这一组操作就必须在一个事务的范围内，即要么都成功，要么都失败。总不可能在出现异常后，张三的余额减少了，李四的余额却没有增加。

假设没有开启事务，也就是这一系列操作不在一个事务的范围内：

- 理想情况：

  ![image-20230915115553185](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309151156109.png)

- 假设抛出了异常：

  ![image-20230915121120731](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309151212683.png)

- 为了解决上述的问题，就需要通过开启事务来完成，只需要在业务逻辑执行之前开启事务，执行完毕后必须提交事务，如果执行过程中报错，则回滚事务，把数据恢复到事务开始之前的状态。

  ![image-20230915134849804](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309151348054.png)

值得一提的是，默认MySQL的事务是自动提交的，也就是说，当**执行完一条DML语句时，MySQL会立即隐式的提交事务**。即默认情况下，**一条SQL语句就是一个事务**。假如**关闭自动提交则必须在每次执行SQL之后手动提交事务，否则SQL不生效**。

## 事务操作

### 查看事务提交方式

**基本语法**：

```mysql
SELECT @@autocommit;
```

- `1` 表示**自动提交事务**
- `0`表示**手动提交事务**

![image-20230915135120610](./assets/image-20230915135120610.png)

### 设置事务提交方式

**设置为手动提交事务**：

```mysql
SET @@autocommit = 0;
```

**设置为自动提交事务**：

```mysql
SET @@autocommit = 1;  
```

![image-20230915135455507](./assets/image-20230915135455507.png)

### 提交事务

**基本语法**：

```mysql
COMMIT;
```

**例**：

把事务的提交方式修改为了手动提交来验证一下"**关闭自动提交事务则必须在每次执行SQL之后手动提交事务，否则SQL不生效**"：

![image-20230915140655529](./assets/image-20230915140655529.png)

由于关闭了自动提交事务，执行SQL后发现执行成功，但没有提交事务，查看数据库发现数据并未发生变化。待提交事务后，数据才更新：
![image-20230915140946450](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309151409876.png)

### 回滚事务

**基本语法**：

```mysql
ROLLBACK;
```

当执行事务的过程中碰到了异常导致中止，可以使用`ROLLBACK`使得事务回滚，即恢复事务开始执行之前的状态。

### 开启事务

**基本语法**：

```sql
START TRANSACTION; 
```

```mysql
BEGIN;
```

除了可以以关闭自动提交事务，然后手动commit的方式控制事务以外，还可以通过在SQL开始执行之前，先执行`START TRANSACTION; `或 `BEGIN;`然后执行SQL，最后`COMMIT;`的方式控制事务。

![image-20230915141909394](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309151419658.png)

## 四大特性

事务四大特性 (`ACID`)：

- **原子性** (`A`tomicity)：事务是不可分割的最小操作单元，要么全部成功，要么全部失败

  ![image-20230915144548936](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309151445691.png)

- **一致性** (`C`onsistency)：事务完成时，必须使所有的数据都保持一致状态。

- **隔离性** (`I`solation)：数据库系统提供的隔离机制，保证事务在不受外部并发操作影响的独立 环境下运行。

  ![image-20230915144843956](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309151448509.png)

- **持久性** (`D`urability)：事务一旦提交或回滚，它对数据库中的数据的改变就是永久的。

  ![image-20230915150320615](./assets/image-20230915150320615.png)

## 并发事务问题

**多个事务同时操作某一个数据库或者某一张表**时，可能会产生一系列问题：

- **赃读**：一个事务读到另外一个事务还没有提交的数据
  ![在这里插入图片描述](https://img-blog.csdnimg.cn/808935c2df0d4fe2948c6700198003de.png)
- **不可重复读**：一个事务先后读取同一条记录，但两次读取的数据不同，称之为不可重复读。
  ![在这里插入图片描述](https://img-blog.csdnimg.cn/e9703d8cc0804a3ab8002a1d3831c634.png)
- **幻读**：一个事务按照条件查询数据时，没有对应的数据行，但是在插入数据时，又发现这行数据已经存在，好像出现了 “幻影”。

![在这里插入图片描述](https://img-blog.csdnimg.cn/0ca4ad3240cd49d19c74de40f39af7e3.png)

## 事务隔离级别

为了**解决并发事务所引发的问题**，在数据库中引入了事务隔离级别。主要有以下几种：

| 隔离级别（发生- √，不发生- ×）      | 脏读 | 不可重复读 | 幻读 |
| ----------------------------------- | ---- | ---------- | ---- |
| `Read uncommitted`（读未提交）      | √    | √          | √    |
| `Read committed`（读已提交）        | ×    | √          | √    |
| `Repeatable Read`（可重复读）(默认) | ×    | ×          | √    |
| `Serializable` （串行化）           | ×    | ×          | ×    |

MySQL**默认**的隔离级别为`Repeatable Read`，也就是只会产生幻读问题。当然，随着安全系数的增加，数据库的性能也有所下降。

- 查看事务隔离级别

```sql
SELECT @@TRANSACTION_ISOLATION;
```

![在这里插入图片描述](https://img-blog.csdnimg.cn/c358ea58c8aa4fda99bfd4c512f161f4.png)

- 设置事务隔离级别

```sql
SET  [ SESSION | GLOBAL ]  TRANSACTION  ISOLATION  LEVEL  { READ UNCOMMITTED | 
READ COMMITTED | REPEATABLE READ | SERIALIZABLE }
```

![在这里插入图片描述](https://img-blog.csdnimg.cn/1e9dc23abf0e4dd4b357bec23b59ca1c.png)
