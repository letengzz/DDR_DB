# 锁

**锁是计算机协调多个进程或线程并发访问某一共享资源的机制**。在数据库中，除传统的计算资源（CPU、 RAM、I/O）的争用以外，数据也是一种供许多用户共享的资源。因此合理使用锁对于保证数据库数据并发访问的一致性、有效性十分重要，而不合理使用锁导致的锁冲突将会影响数据库并发访问性能。
![在这里插入图片描述](https://img-blog.csdnimg.cn/48855f9eff2c4ee0b3c57accad18c894.png)

MySQL中的锁，**按照锁的粒度**，分为以下三类：

- 全局锁：锁定数据库中的所有表。
- 表级锁：每次操作锁住整张表。
- 行级锁：每次操作锁住对应的行数据。

## 全局锁

**全局锁就是对整个数据库实例加锁，加锁后整个实例就处于只读状态**，加锁期间请求的DML语句，DDL语句，已经更新操作的事务提交语句都将被阻塞（无法生效）。 其典型的使用场景是做全库的逻辑备份，对所有的表进行锁定，从而获取一致性视图，保证数据的完整性。

为什么全库逻辑备份，就需要加全就锁呢？ 我们先来分析一下不加全局锁可能存在的问题：
![在这里插入图片描述](https://img-blog.csdnimg.cn/13d6b22e7a2640358f49ed80092f3a22.png)

- 假设在数据库中存在这样三张表: tb_stock 库存表，tb_order 订单表，tb_orderlog 订单日志表。
- 在进行数据备份时，先备份了tb_stock库存表。
- 然后接下来，在业务系统中，执行了下单操作，扣减库存，生成订单（更新tb_stock表，插入 tb_order表）。
- 然后再执行备份 tb_order表的逻辑。
- 业务中执行插入订单日志操作。
- 最后，又备份了tb_orderlog表。
- 此时备份出来的数据，是存在问题的。因为备份出来的数据，tb_stock表与tb_order表的数据不一致(有最新操作的订单信息,但是库存数没减)。

加了全局锁后的情况：
![在这里插入图片描述](https://img-blog.csdnimg.cn/2bb1cafd106b4d23b1f30abcd0ef8122.png)

对数据库进行进行逻辑备份之前，先对整个数据库加上全局锁，一旦加了全局锁之后，其他的DDL、 DML全部都处于阻塞状态，但是可以执行DQL语句，也就是处于只读状态。而数据备份就是查询操作，此时在逻辑备份的过程中，数据库中的数据不会再发生变化，这样就保证了数据的一致性和完整性。

### 语法

#### 加锁

- 语法

```sql
flush tables with read lock; 
1
```

#### 数据备份

- 语法

```sql
mysqldump -h地址 -u账号 –p密码  数据库名称 > 存放路径/文件名称.sql 
1
```

- 在InnoDB引擎中，我们可以在备份时加上参数 `--single-transaction` 参数来实现**不加锁的一致性数据备份**。

```sql
mysqldump  --single-transaction  -h地址 -u账号 –p密码  数据库名称 > 存放路径/文件名称.sql 
1
```

#### 释放锁

- 语法

```sql
unlock tables;
1
```

![在这里插入图片描述](https://img-blog.csdnimg.cn/63bb13d28f4b469a978666ddfd9344a7.png)

#### 演示示例

- 进行备份操作

![在这里插入图片描述](https://img-blog.csdnimg.cn/cbc761049b2a482c97a5b62f0bbc28fb.png)

需要注意的是我们备份操作是在cmd命令行中进行，而不是数据库内部。

![在这里插入图片描述](https://img-blog.csdnimg.cn/51193de7260d47f4a3e5a55a06cc6f32.png)

### 缺点

数据库中加全局锁，是一个比较重的操作，存在以下问题：

- 如果在**主库**上备份，那么在**备份期间都不能执行更新，在此期间非查询业务无法正常执行**。
- 如果在**从库**上备份，那么在**备份期间从库不能执行主库同步过来的二进制日志（binlog），会导致主从延迟**。

在InnoDB引擎中，我们可以在备份时加上参数 `--single-transaction` 参数来实现**不加锁的一致性数据备份**。

```sql
mysqldump  --single-transaction  -h地址 -u账号 –p密码  数据库名称 > 存放路径/文件名称.sql 
1
```

## 表级锁

表级锁，**每次操作锁住整张表**。锁定粒度大，发生锁冲突的概率最高，并发度最低。对于表级锁，主要分为以下三类：

- 表锁
  - 表共享读锁（read lock）
  - 表独占写锁（write lock）
- 元数据锁（meta data lock，MDL）
- 意向锁

### 表锁

表锁又分为 **表共享读锁**（`read lock`）和 **表独占写锁**（`write lock`）。

#### 语法

加锁：

```sql
lock tables 表名 read/write;
1
```

释放锁：

```sql
unlock tables;
1
```

#### 表共享读锁

对表添加读锁，则该表只能进行读操作，将会拒绝添加锁客户端的写操作，阻塞其他客户端的写操作。
![在这里插入图片描述](https://img-blog.csdnimg.cn/87d49544b6aa4657984584ae1798eff2.png)

- 测试

![在这里插入图片描述](https://img-blog.csdnimg.cn/4b0288e1e0e242a0b87b53b85e1c75a5.png)

### (2.3) 表独占写锁

对表添加写锁，则只能在添加写锁的客户端进行读操作和写操作，将会阻塞其他客户端的读操作以及写操作。

![在这里插入图片描述](https://img-blog.csdnimg.cn/4f3b8c41170c4914bc1f230765f0e7cf.png)

- 测试

![在这里插入图片描述](https://img-blog.csdnimg.cn/e9f1e22e6f064edc9f956b57bde3f273.png)

### (2.4) 对比

|                | **当前**客户端**读** | **当前**客户端**写** | **其他**客户端**读** | **其他**客户端**写** |
| -------------- | -------------------- | -------------------- | -------------------- | -------------------- |
| **表共享读锁** | 允许                 | 拒绝                 | 允许                 | 阻塞                 |
| **表独占写锁** | 允许                 | 允许                 | 阻塞                 | 阻塞                 |

## (3) 元数据锁

元数据锁（meta data lock），简写`MDL`。其加锁过程是**系统自动控制的，无需显式调用，在访问一张表的时候会自动加上**。MDL锁主要作用是维护表元数据的数据一致性，在表上有活动事务的时候，不可以对元数据进行写入操作。为了避免DML与 DDL冲突，保证读写的正确性。

**这里的元数据，可以简单理解为就是一张表的表结构**。 也就是说，**某一张表涉及到未提交的事务时，在增删改查内容时不能够修改这张表的表结构的，而在修改表结构时不能增删改查表内容**。

在MySQL5.5中引入了MDL，当对一张表进行**增删改查**的时候，加**MDL读锁(共享)**；当对**表结构进行变更**操作的时候，加**MDL写锁(排他)**。常见的SQL操作时，所自动添加的元数据锁：

| 对应SQL                                       | 锁类型                                  | 说明                                               |
| --------------------------------------------- | --------------------------------------- | -------------------------------------------------- |
| lock tables xxx read / write                  | SHARED_READ_ONLY / SHARED_NO_READ_WRITE |                                                    |
| select 、select … lock in share mode          | SHARED_READ                             | 与SHARED_READ、 SHARED_WRITE兼容，与 EXCLUSIVE互斥 |
| insert 、update、 delete、select … for update | SHARED_WRITE                            | 与SHARED_READ、 SHARED_WRITE兼容，与 EXCLUSIVE互斥 |
| alter table …                                 | EXCLUSIVE                               | 与其他的MDL都互斥                                  |

当执行SELECT、INSERT、UPDATE、DELETE等语句时，添加的是元数据共享锁（SHARED_READ / SHARED_WRITE），之间是兼容的。

![在这里插入图片描述](https://img-blog.csdnimg.cn/d824a225ee5d407ba992fd519a08a8bb.png)

当执行SELECT语句时，添加的是元数据共享锁（SHARED_READ），会阻塞元数据排他锁 （EXCLUSIVE），之间是互斥的

![在这里插入图片描述](https://img-blog.csdnimg.cn/5348d20cc477428e8499505cbd70c83f.png)

我们可以通过下面的SQL，来查看数据库中的元数据锁的情况：

```sql
select object_type,object_schema,object_name,lock_type,lock_duration from 
performance_schema.metadata_locks ;
12
```

![在这里插入图片描述](https://img-blog.csdnimg.cn/f51a576714f44901aa01f55ec1e68b4e.png)

## (4) 意向锁

### (4.1) 概述

为了**避免DML在执行时，加的行锁与表锁的冲突**，在InnoDB中引入了意向锁，使得添加表锁时不用检查每行数据是否添加行锁，使用意向锁**减少表锁的检查**。

假如没有意向锁，客户端一对表加了行锁后，客户端二如何给表加表锁呢，来通过示意图简单分析一 下：

![在这里插入图片描述](https://img-blog.csdnimg.cn/2a2935e48cd64001b081349d69f35068.png)

- 首先客户端一，开启一个事务，然后根据索引执行DML操作，会对涉及到的行加行锁。当客户端二，想对这张表加表锁时，会逐行检查当前表是否有对应的行锁，如果没有，则添加表锁，由于会从第一行数据，检查到最后一行数据，效率较低。

有了意向锁之后 :

![在这里插入图片描述](https://img-blog.csdnimg.cn/60ec4ab0d94146b0baabf8330862a39c.png)

- 客户端一，在执行DML操作时，在加行锁的同时也会对该表加上意向锁。此时其他客户端，在对这张表加表锁的时候，会根据该表上所加的意向锁来判定是否可以成功加表锁，而不用逐行判断行锁情况了 ，极大的提高了效率。

### (4.2) 使用

意向锁又分为：

- **意向共享锁(IS)**: 由语句select … lock in share mode添加 。与 表锁共享锁 (read)兼容，与表锁独占锁(write)互斥。
- **意向排他锁(IX)**: 由insert、update、delete、select…for update添加 。与表锁共享锁(read)及独占锁(write)都互斥，意向锁之间不会互斥。

一旦事务提交了，意向共享锁、意向排他锁，都会自动释放。

意向共享锁与表读锁是兼容的：

![在这里插入图片描述](https://img-blog.csdnimg.cn/fca8c9cb2fa14362b9f0768fa380b537.png)

意向排他锁与表读锁、写锁都是互斥的：

![在这里插入图片描述](https://img-blog.csdnimg.cn/49e038b550514c2ca93b486dbb2514ce.png)

# 四.行级锁

## (1) 概述

行级锁，**每次操作锁住对应的行数据**。锁定粒度最小，发生锁冲突的概率最低，并发度最高，应用在 InnoDB存储引擎中。 InnoDB的数据是基于索引组织的，而**行锁是通过对索引上的索引项加锁来实现的，而不是对记录加的锁**，也就是说根据索引字段操作数据行才生效，否则行锁会升级为表锁。

对于行级锁，主要分为以下三类：

- **行锁**（Record Lock）：**锁定单个行记录的锁**，防止其他事务对此行进行update和delete。在 RC、RR隔离级别下都支持。

![在这里插入图片描述](https://img-blog.csdnimg.cn/23368c7533764ddb920d9a677d9fc6f2.png)

- **间隙锁**（Gap Lock）：**锁定索引记录间隙**（不含该记录），确保索引记录间隙不变，防止其他事务在这个间隙进行insert，产生幻读。在RR隔离级别下都支持。

![在这里插入图片描述](https://img-blog.csdnimg.cn/3fbafe26b21549a58d933eb23eccad37.png)

- **临键锁**（Next-Key Lock）：行锁和间隙锁组合，**同时锁住数据以及数据前面的间隙Gap**。 在RR隔离级别下支持

![在这里插入图片描述](https://img-blog.csdnimg.cn/9793c5bf6ced4d069dbb1f99c03c811e.png)

默认情况下，InnoDB在 REPEATABLE READ事务隔离级别运行，InnoDB使用临键 (next-key) 锁进行搜索和索引扫描，以防止幻读。

## (2) 行锁

InnoDB实现了以下两种类型的行锁：

- **共享锁**（S）：允许一个事务去读某一行，阻止其他事务获得相同数据集的排它锁。 兼容其他共享锁，排斥排他锁。
- **排他锁**（X）：允许获取排他锁的事务更新数据，阻止其他事务获得相同数据集的共享锁和排他锁。排斥共享锁与其他排他锁。

常见的SQL语句，在执行时，所加的行锁如下：

| SQL                         | 行锁类型   | 说明                                     |
| --------------------------- | ---------- | ---------------------------------------- |
| INSERT …                    | 排他锁     | 自动加锁                                 |
| UPDATE …                    | 排他锁     | 自动加锁                                 |
| DELETE …                    | 排他锁     | 自动加锁                                 |
| SELECT（正常）              | 不加任何锁 |                                          |
| SELECT … LOCK IN SHARE MODE | 共享锁     | 需要手动在SELECT之后加LOCK IN SHARE MODE |
| SELECT … FOR UPDATE         | 排他锁     | 需要手动在SELECT之后加FOR UPDATE         |

- 针对唯一索引进行检索时，对已存在的记录进行等值匹配时，将会自动优化为行锁。
- InnoDB的**行锁是针对于索引加的锁**，**不通过索引条件检索数据**，那么InnoDB将对表中的所有记录加锁，此时就**会升级为表锁**。

**演示示例**：

1. 普通的select语句，执行时，不会加锁。

![在这里插入图片描述](https://img-blog.csdnimg.cn/840fe64db6b54a2c95070ebfafcad913.png)

1. select…lock in share mode，加共享锁，共享锁与共享锁之间兼容

![在这里插入图片描述](https://img-blog.csdnimg.cn/8fee56093c2b40248e03d881b4dc50bf.png)

1. 共享锁与排他锁之间互斥。

![在这里插入图片描述](https://img-blog.csdnimg.cn/e69590f1fd1049b3b04ed9f36c2ffc41.png)

由于是根据主键索引进行等值匹配修改，所以加的是行锁。客户端一获取的是id为1这行的共享锁，客户端二是可以获取id为3这行的排它锁的，因为不是同一行数据。 而如果客户端二想获取id为1这行的排他锁，会处于阻塞状态，因为共享锁与排他锁之间互斥。

1. 排它锁与排他锁之间互斥

![在这里插入图片描述](https://img-blog.csdnimg.cn/7eaacc0e98a74b4181f7a4ea3c5eef3a.png)

当客户端一，执行update语句，会为id为1的记录加排他锁； 客户端二，如果也执行update语句更 新id为1的数据，也要为id为1的数据加排他锁，但是客户端二会处于阻塞状态，因为排他锁之间是互 斥的。 直到客户端一，把事务提交了，才会把这一行的行锁释放，此时客户端二，解除阻塞。

1. 使用无索引字段行锁升级为表锁

![在这里插入图片描述](https://img-blog.csdnimg.cn/8a38e46392ec4623bf59c0dda084f70d.png)

行锁是对索引项加的锁，而name没有索引，根据其进行操作将导致行锁升级为表锁。

![在这里插入图片描述](https://img-blog.csdnimg.cn/6616a7ac4dd04cdd938421c0c68bb8a3.png)

创建索引后，根据索引字段进行更新操作，就可以避免行锁升级为表锁的情况

## (3) 间隙锁&临键锁

- 通过唯一索引进行等值查询，给不存在的记录加锁时, 优化为间隙锁 。
- 通过非唯一普通索引进行等值查询，向右遍历时最后一个值不满足查询需求时，临键 (next-key) 锁退化为间隙锁。
- 通过唯一索引上进行范围查询，会访问到不满足条件的第一个值为止。

间隙锁唯一目的是防止其他事务插入间隙。间隙锁可以共存，一个事务采用的间隙锁不会阻止另一个事务在同一间隙上采用间隙锁。

1. 索引上的等值查询(唯一索引)，给不存在的记录加锁时, 优化为间隙锁

![在这里插入图片描述](https://img-blog.csdnimg.cn/fa8cd686113d4dadbb3d1c40aa152fc1.png)

1. 索引上的等值查询(非唯一普通索引)，向右遍历时最后一个值不满足查询需求时，next-key lock 退化为间隙锁

![在这里插入图片描述](https://img-blog.csdnimg.cn/23b57adc84e7463c97f765e46eb43c21.png)

我们知道InnoDB的B+树索引，叶子节点是有序的双向链表。 假如，我们要根据这个二级索引查询值 为18的数据，并加上共享锁，我们是只锁定18这一行就可以了吗？ 并不是，因为是非唯一索引，这个 结构中可能有多个18的存在，所以，在加锁时会继续往后找，找到一个不满足条件的值（当前案例中也 就是29）。此时会对18加临键锁，并对29之前的间隙加锁.

![在这里插入图片描述](https://img-blog.csdnimg.cn/2a517d447b5742eea1561c14f9d940c4.png)

1. 索引上的范围查询(唯一索引)–会访问到不满足条件的第一个值为止。

![在这里插入图片描述](https://img-blog.csdnimg.cn/0f10d7f99d2341f48466f5b1cac8c8da.png)

查询的条件为id>=19，并添加共享锁。 此时我们可以根据数据库表中现有的数据，将数据分为三个部 分： [19] (19,25] (25,+∞].所以数据库数据在加锁是，就是将19加了行锁，25的临键锁（包含25及25之前的间隙），正无穷的临键锁(正无穷及之前的间隙)。