# 存储过程

存储过程是**事先经过编译并存储在数据库中的一段 SQL 语句的集合**，调用存储过程可以简化应用开发人员的工作，**可以减少数据在数据库和应用服务器之间的传输**，提高数据处理的效率。 存储过程相当于数据库 SQL 语言层面的代码封装与重用。
![在这里插入图片描述](https://img-blog.csdnimg.cn/5dce2addec1f4d49974a5022e75650af.png)

用途：

- 可以把某一业务SQL封装在存储过程中，需要用到的时候直接调用即可。
- 类似于其他语言的函数(方法)，在使用存储过程中，可以传递参数，也可以接收返回值。
- 减少客户端与数据库的网络交互，提高执行效率，如果涉及到多条SQL执行，每执行一次都是一次网络传输。 而如果封装在存储过程中，我们只需要网络交互一次可能就可以了。

## 创建存储过程

### 在客户端创建

- 语法

```sql
CREATE PROCEDURE 存储过程名称 ([ 参数列表 ])
BEGIN
-- SQL语句
END;
```

- 创建一个最简单的存储过程

![在这里插入图片描述](https://img-blog.csdnimg.cn/d6632540fe274f068fd3b3e55fbd5c94.png)

### 在命令行创建

在命令行中，**默认以分号表示语句的结束**，因此我们无法像上述一样直接创建存储过程。
![在这里插入图片描述](https://img-blog.csdnimg.cn/879d7cac294d4b79a7c9645713542384.png)

我们需要先通过关键字 `delimiter`**重新指定SQL语句的结束符**,再执行即可。

![在这里插入图片描述](https://img-blog.csdnimg.cn/7c38ab64de2b4b90abd2d64b9256b15d.png)

## 调用

- 语法

```sql
CALL 名称 ([ 参数列表 ]);
1
```

- 调用创建的存储过程
  ![在这里插入图片描述](https://img-blog.csdnimg.cn/caec9a18ddfb49eebe4044bc5e4e77c1.png)

## (3) 查看

- 语法

```sql
-- 方式一:查询指定数据库的存储过程及状态信息
SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA = '数据库名称'; 

 -- 方式二:查询某个存储过程的定义
SHOW CREATE PROCEDURE 存储过程名称; 
12345
```

- 方式一

![在这里插入图片描述](https://img-blog.csdnimg.cn/4248dd592dd149b6987ebb7b703926ef.png)

- 方式二

![在这里插入图片描述](https://img-blog.csdnimg.cn/76f47f6f792b4738a186d714f2f2edc5.png)

## (4) 删除

- 语法

```sql
DROP PROCEDURE [ IF EXISTS ] 存储过程名称;
1
```

# 三.进阶使用

由于我们可以在存储过程中封装多条SQL，传递变量，获取返回结果。因此面对复杂的情况，我们可以辅以一系列的逻辑。

## (1) 变量

在MySQL中变量分为三种类型: 系统变量、用户定义变量、局部变量。

### (1.1) 系统变量

系统变量 是MySQL服务器提供，属于服务器层面，其中又分为全局变量、会话变量

- 全局变量(`GLOBAL`): 设置后针对于所有的会话生效
- 会话变量(`SESSION`): 只对当前会话生效，在另外一个会话窗口就不生效了

#### (1.1.1) 查看系统变量

- 方式一：查看所有系统变量

```sql
SHOW [ SESSION | GLOBAL ] VARIABLES;                  
1
```

![在这里插入图片描述](https://img-blog.csdnimg.cn/d00b1f3125804fad9d82c963e146b1c1.png)

- 方式二：通过LIKE模糊匹配方式查找变量

```sql
SHOW [ SESSION | GLOBAL ] VARIABLES LIKE '......';  
1
```

![在这里插入图片描述](https://img-blog.csdnimg.cn/679896a31de04ec08ec5ee70a46c189d.png)

- 方式三：查看指定变量的值

```sql
SELECT @@[SESSION | GLOBAL] 系统变量名; 
1
```

![在这里插入图片描述](https://img-blog.csdnimg.cn/b1d32f45a7a84dc3ac8585c6ec976631.png)

#### (1.1.2) 设置系统变量

- 语法一

```sql
SET [ SESSION | GLOBAL ] 系统变量名 = 值 ; 
1
```

![在这里插入图片描述](https://img-blog.csdnimg.cn/38fbcd3d0da549e8a3c4b927eb5cdab1.png)

- 语法二

```sql
SET @@[SESSION | GLOBAL ]系统变量名 = 值 ; 
1
```

![在这里插入图片描述](https://img-blog.csdnimg.cn/0075c4b626de438bb7e046de290bfde9.png)

注意事项

- 如果没有指定`SESSION/GLOBA`L，**默认**是`SESSION`，会话变量
- mysql服务**重新启动之后，所设置的全局参数会失效**，要想不失效，可以在 `/etc/my.cnf` 中配置

### (1.2) 用户定义变量

用户根据需要自己定义的变量，可以不提前声明直接使用（返回null），在用的时候直接用 “`@变量名`” 就可以。其作用域为当前连接。

#### (1.2.1) 赋值（声明）

- 方式一

```sql
-- 赋值时，可以使用 = ，也可以使用 := 
SET @var_name = expr [, @var_name = expr] ... ; 
SET @var_name := expr [, @var_name := expr] ... ;

-- ===使用示例===
set @test1 := 111  -- 可为单个变量声明赋值
set @test2 := 222,@test3=333  -- 可为多个变量声明赋值
1234567
```

- 方式二

```sql
SELECT @var_name := expr  [, @var_name := expr] ... 

SELECT 字段名 INTO @var_name FROM 表名;

-- ===使用示例===
SELECT @test4 := 444
SELECT age INTO @test5 FROM user WHERE id =1; -- 需确保结果为一个
1234567
```

![在这里插入图片描述](https://img-blog.csdnimg.cn/db044271066c41bcb88dda3abd850f2e.png)

#### (1.2.2) 查看

- 语法

```sql
SELECT  @变量名 ;
1
```

![在这里插入图片描述](https://img-blog.csdnimg.cn/3f89058e0e7f470bb6c1fa56ca9fee9d.png)

### (1.3) 局部变量

定义在局部生效的变量，访问之前，需要先使用`DECLARE`声明。**可用作存储过程内的局部变量和输入参数**，局部变量的**范围是在其内声明的**`BEGIN ... END`块。

#### (1.3.1) 声明

- 语法

```sql
create procedure 存储过程名称 ([ 参数列表 ])
begin
    declare 变量名 变量类型 [DEFAULT ... ];
    -- ....
    -- SQL语句
end;
123456
```

可以同时定义多个局部变量，变量类型就是数据库字段类型：INT、BIGINT、CHAR、VARCHAR、DATE、TIME等。

#### (1.3.2) 赋值

- 语法（与上述类似）

```sql
-- 方式一
SET 变量名 = 值 ;
-- 方式二
SET 变量名 := 值 ;
-- 方式三
SELECT 字段名 INTO 变量名  FROM  表名 ... ;
123456
```

- 完整示例

![在这里插入图片描述](https://img-blog.csdnimg.cn/dc7cd3151e8d49c8a80e3ed116f2876f.png)

## (2) if 判断

- 语法

```sql
-- 完整版
IF 条件1 THEN 
    .....
ELSEIF 条件2 THEN       -- 可选
   .....
ELSE                     -- 可选
   .....
END IF;

-- 简洁版
IF 条件1 THEN 
    .....
END IF;
12345678910111213
```

在if条件判断的结构中，`ELSE IF` 结构可以有多个，也可以没有。 `ELSE`结构可以有，也可以没有。

- 使用示例

根据定义的分数score变量，判定当前分数对应的分数等级。 score >= 85分，等级为优秀。 score >= 60分 且 score < 85分，等级为及格。 score < 60分，等级为不及格。

```sql
-- 创建存储过程
create procedure p3()
 begin
 	-- 定义变量
    declare score int default 58;
    declare result varchar(10);
    -- if判断
    if score >= 85 then
        set result := '优秀';
    elseif score >= 60 then
        set result := '及格';
    else
        set result := '不及格';
    end if;
    -- 查看参数值
    select result;
 end;
 -- 调用存储过程
 call p3();
12345678910111213141516171819
```

![在这里插入图片描述](https://img-blog.csdnimg.cn/46319ccb175d4a2aad910fdc8b1ff132.png)

上述的需求我们虽然已经实现了，但是也存在一些问题，比如：score 分数我们是在存储过程中定义死的，而且最终计算出来的分数等级，我们也仅仅是最终查询展示出来而已，非常的鸡肋。接下来我们就学习一下参数的使用，把score分数动态的传递进来，再把计算出来的分数等级作为返回值返回。

## (3) 参数

参数的类型，主要分为以下三种：IN、OUT、INOUT。 具体的含义如下：

| 类型    | 含义                                     |
| ------- | ---------------------------------------- |
| `IN`    | 表示输入参数，也就是调用时需要传入值     |
| `OUT`   | 表示输出参数，也就是该参数可以作为返回值 |
| `INOUT` | 既可以作为输入参数，也可以作为输出参数   |

- 语法

```sql
CREATE  PROCEDURE   存储过程名称 ([ [IN | OUT | INOUT] 参数名 参数类型 ])
BEGIN
    -- SQL语句
END ;
1234
```

改进一下上述if判断中查看分数等级示例

```sql
-- 创建存储过程
-- in score int 表示需要传入一个整数型的参数
-- out result varchar(10) 表示返回一个varchar(10)的字符串参数
create procedure p4(in score int, out result varchar(10))
 begin
    if score >= 85 then
        set result := '优秀';
    elseif score >= 60 then
 set result := '及格';
    else
        set result := '不及格';
    end if;
 end;
 
-- 定义用户变量 @result来接收返回的数据, 用户变量可以不用声明
-- 调用存储过程 
call p4(18, @result);
-- 查看变量值
select @result;
12345678910111213141516171819
```

![在这里插入图片描述](https://img-blog.csdnimg.cn/3b84d8d67c8e4083af5ac084035a50e1.png)

结果与上述一致，但是变得更加可控。

## (4) case 流程控制

- 语法一

```sql
CASE  case_value
  WHEN when_value1 THEN statement_list1
  [ WHEN when_value2 THEN statement_list2] ...
  [ ELSE statement_list ]
 END  CASE;
12345
```

当case_value的值为 when_value1时，执行statement_list1，当值为 when_value2时，执行statement_list2， 否则就执行 statement_list。

- 使用示例
  ![在这里插入图片描述](https://img-blog.csdnimg.cn/c9fe553463f94c2b95c98dce9184f94f.png)
- 语法二

```sql
CASE
  WHEN search_condition1 THEN statement_list1
  [WHEN search_condition2 THEN statement_list2] ...
  [ELSE statement_list]
 END CASE;
12345
```

当条件search_condition1成立时，执行statement_list1，当条件search_condition2成
立时，执行statement_list2， 否则就执行 statement_list。如果判定条件有多个，多个条件之间，可以使用 and 或 or 进行连接。

- 使用示例

![在这里插入图片描述](https://img-blog.csdnimg.cn/c7105c9450fc43a1a5099f6a328c6e15.png)

## (5) 循环

### (5.1) while

while 循环是有条件的循环控制语句。满足条件后，再执行循环体中的SQL语句。具体语法为：

```sql
WHILE 条件 DO
    -- SQL逻辑...    
END WHILE;
123
```

`先判定条件`，如果条件为true，则执行逻辑，否则，不执行逻辑。

- 使用示例
  ![在这里插入图片描述](https://img-blog.csdnimg.cn/cd937cfbba034999bd160d007f050705.png)

### (5.2) repeat

与while类似，repeat也是有条件的循环控制语句, 当满足until声明的条件的时候，则退出循环 。具体语法为：

```sql
REPEAT
   -- SQL逻辑...  
    UNTIL  条件
END REPEAT;
1234
```

`先执行一次`逻辑，然后判定UNTIL条件是否满足，如果满足，则退出。如果不满足，则继续下一次循环

- 使用示例

![在这里插入图片描述](https://img-blog.csdnimg.cn/1f1253498291404fb5179329c67d530d.png)

### (5.3) loop

LOOP 也可以用来实现循环，如果不在SQL逻辑中增加退出循环的条件，可以用其来实现简单的死循环。 LOOP可以配合一下两个语句使用：

- `LEAVE` ：配合循环使用，退出循环。
- `ITERATE`：必须用在循环中，作用是跳过当前循环剩下的语句，直接进入下一次循环。

```sql
[begin_label:]  LOOP
    -- SQL逻辑...  
   --  LEAVE  label;   -- 退出指定标记的循环体
   --  ITERATE  label; -- 直接进入下一次循环
END  LOOP  [end_label];
12345
```

`begin_label`，`end_label`，`label` 指的都是我们所自定义的标记，用来标记loop循环的范围。

- 使用示例：计算从1到n之间的偶数累加的值，n为传入的参数值

![在这里插入图片描述](https://img-blog.csdnimg.cn/b91cef6460d940d49039beff89e797f6.png)

### (5.3) 区别对比

| 名称     | 区别                                                         |
| -------- | ------------------------------------------------------------ |
| `while`  | **先判定条件**，如果条件为true，则执行逻辑，否则不执行逻辑。 |
| `repeat` | **先执行一次逻辑**，然后判定UNTIL条件是否满足，如果满足，则退出。如果不满足，则继续下一次循环 |
| `loop`   | 可以配合两个语句实现：死循环，退出循环，跳过剩余语句执行下一轮循环 |

## (6) cursor 游标

我们的变量只能存储单个查询结果，而游标（CURSOR）是**用来存储查询结果集**的数据类型 , 在存储过程和函数中可以使用游标对结果集进行循环的处理。

- 声明游标

```sql
DECLARE 游标名称 CURSOR FOR 查询语句;
1
```

- 打开游标

```sql
OPEN 游标名称;
1
```

- 获取游标记录

```sql
FETCH 游标名称 INTO 变量 [,变量 ];
1
```

- 关闭游标

```sql
CLOSE 游标名称;
1
```

使用示例：根据传入的参数uage，来查询用户表tb_user中，所有的用户年龄小于等于uage的用户姓名 （name）和专业（profession），并将用户的姓名和专业插入到所创建的一张新表 (id,name,profession)中

![在这里插入图片描述](https://img-blog.csdnimg.cn/a04f7ca60b274fe7b3eb7c40a5ce0199.png)

在我们调用上述存储过程的过程中，由于while循环中并没有退出条件，当游标的数据集获取完毕之后，再次获取数据，就会报错，从而终止了程序的执行。但是此时，user_pro表结构及其数据都已经插入成功了。 要想解决这个问题，就需要通过MySQL中提供的 条件处理程序 Handler 来解决

## (7) 条件处理程序

条件处理程序（`Handler`）可以用来定义在流程控制结构执行过程中遇到问题时相应的处理步骤。

- 语法

```sql
DECLARE handler_action HANDLER FOR condition_value [,condition_value] ...   statement;
1
```

`handler_action` 的取值：

- `CONTINUE`: 继续执行当前程序
- `EXIT`: 终止执行当前程序

`condition_value` 的取值：

- `SQLSTATE sqlstate_value`: 状态码，如 02000
- `SQLWARNING`: 所有以01开头的SQLSTATE代码的简写
- `NOT FOUND`: 所有以02开头的SQLSTATE代码的简写
- `SQLEXCEPTION`: 所有没有被SQLWARNING 或 NOT FOUND捕获的SQLSTATE代码的简写

我们来处理完善一下上一个案例所遇到的问题~

![在这里插入图片描述](https://img-blog.csdnimg.cn/8fd237184e844bce8b802187f84cc1cb.png)

- 多种写法示例:

```sql
-- 当SQL语句执行抛出的状态码为02000开头时，将关闭游标u_cursor，并退出
 declare exit handler for SQLSTATE '02000' close u_cursor;
 
 -- 当SQL语句执行抛出的状态码为02开头时，将关闭游标u_cursor，并退出
 declare exit handler for not found close u_cursor;
 
 -- 当SQL语句执行抛出的异常没有其他处理程序处理时，将关闭游标u_cursor，并退出
 declare exit handler for SQLEXCEPTION close u_cursor;
12345678
```

常见错误状态码可参考[官方文档](https://dev.mysql.com/doc/mysql-errors/8.0/en/server-error-reference.html)。

# 四.存储函数

存储函数**是有返回值的存储过程**，存储函数的参数只能是`in`类型的。具体语法如下：

```sql
CREATE  FUNCTION   存储函数名称 ([ 参数列表 ])
RETURNS  type  [characteristic ...]
BEGIN
	-- SQL语句
	RETURN ...;
END ;
123456
```

characteristic参数说明：

- `DETERMINISTIC`：相同类型的输入参数总是产生相同类型的结果
- `NO SQL` ：不包含 SQL 语句。
- `READS SQL DATA`：包含读取数据的语句，但不包含写入数据的语句。

使用示例：计算从1累加到n的值，n为传入的参数值

![在这里插入图片描述](https://img-blog.csdnimg.cn/5a3fde7b566747bd9da5e3597d247bb0.png)

注意：在mysql8.0版本中`binlog`默认是开启的，一旦开启了，mysql就要求在定义存储过程时，需要指定 characteristic特性，否则就会报如下错误：

![在这里插入图片描述](https://img-blog.csdnimg.cn/2744bd874c3d44e1956e1631201a86c0.png)