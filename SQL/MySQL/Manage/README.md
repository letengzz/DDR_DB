# MySQL管理

## 系统数据库

MySQL8.0数据库安装完成后，自带了一下四个数据库，具体作用如下：

| 数据                 | 含义                                                         |
| -------------------- | ------------------------------------------------------------ |
| `mysql`              | 存储MySQL服务器正常运行所需要的各种信息 （时区、慢日志、主从复制、用 户、权限等） |
| `information_schema` | 提供了访问数据库元数据的各种表、视图以及存储函数，包含数据库、表、字段类型及访问权限等 |
| `performance_schema` | 为MySQL服务器运行时状态提供了一个底层监控功能，主要用于收集数据库服务器性能参数，例如加锁情况、二进制日志等 |
| `sys`                | 包含了一系列方便 DBA 和开发人员利用 performance_schema 性能数据库进行性能调优和诊断的视图 |

## 常用工具

直接在命令行使用即可，不需要连接后进入mysql内执行。

### mysql

**用途**：mysql的客户端工具。使用`-e`选项可以在命令行执行SQL语句，而不用连接到MySQL数据库再执行，对于一些批处理脚本， 这种方式尤其方便。

```sql
-- 语法 ：    
    mysql [options] [database]
-- 常用选项 ： 
    -u, --user=name         #指定用户名
    -p, --password[=name]           #指定密码
    -h, --host=name         #指定服务器IP或域名
    -P, --port=port             #指定连接端口
    -e, --execute=name          #执行SQL语句并退出
-- 可以通过如下命令查看详细用法
	mysql --help
12345678910
```

演示示例：
![在这里插入图片描述](https://img-blog.csdnimg.cn/61e08661c0ca4d2d99646807dc3c4780.png)

## mysqladmin

**用途**：mysqladmin是一个执行管理操作的客户端程序。可以用它来检查服务器的配置和当前状态、创建并删除数据库等。

```sql
-- 语法 ：    
    mysqladmin [options] command ...
-- 常用选项 ： 
    -u, --user=name         #指定用户名
    -p, --password[=name]           #指定密码
    -h, --host=name         #指定服务器IP或域名
    -P, --port=port             #指定连接端口
-- 可以通过如下命令查看详细用法
	mysqladmin --help
123456789
```

演示示例：
![在这里插入图片描述](https://img-blog.csdnimg.cn/37a183d2ccd446bd8660bcfa8e901431.png)

## mysqlbinlog

**用途**：由于服务器生成的二进制日志文件以二进制格式保存，所以如果查看这些文件，就需要使用到mysqlbinlog日志管理工具。

```sql
-- 语法 ：    
	mysqlbinlog [options]  log-files1 log-files2 ...
-- 选项 ： 
	-d, --database=name        #  指定数据库名称，只列出指定的数据库相关操作。
	-o, --offset= #            #  忽略掉日志中的前n行命令。
	-r,--result-file=name      #  将输出的文本格式日志输出到指定文件。
	-s, --short-form           #  显示简单格式， 省略掉一些信息。
    --start-datatime=date1  --stop-datetime=date2  # 指定日期间隔内的所有日志
	--start-position=pos1 --stop-position=pos2     # 指定位置间隔内的所有日志。
-- 可以通过如下命令查看详细用法
	mysqlbinlog --help
1234567891011
```

演示示例：
![在这里插入图片描述](https://img-blog.csdnimg.cn/b96b6ea8c450469e892ab3267e6fb663.png)

## mysqlshow

**用途**：mysqlshow是一个客户端对象查找工具，可以用来很快地查找存在哪些数据库、数据库中的表、表中的列或者索 引。

```sql
-- 语法 ：    
    mysqlshow [options] [db_name [table_name [col_name]]]
-- 选项 ： 
    --count     -- 显示数据库及表的统计信息（数据库，表 均可以不指定）
    -i      -- 显示指定数据库或者指定表的状态信息
-- 可以通过如下命令查看详细用法
	mysqlshow --help
1234567
```

演示示例
![在这里插入图片描述](https://img-blog.csdnimg.cn/9186c4a297b2421f855c728aac9d8a13.png)

## mysqldump

**用途**：mysqldump 客户端工具用来备份数据库或在不同数据库之间进行数据迁移。备份内容包含创建表，及插入表的SQL语句

```sql
-- 语法 ：    
    mysqldump [options] db_name [tables]
    mysqldump [options] --database/-B db1 [db2 db3...]
    mysqldump [options] --all-databases/-A
-- 连接选项 ：  
    -u, --user=name                 指定用户名
    -p, --password[=name]           指定密码
    -h, --host=name                 指定服务器ip或域名
    -P, --port=#                    指定连接端口
-- 输出选项：
    --add-drop-database         在每个数据库创建语句前加上 drop database 语句
    --add-drop-table            在每个表创建语句前加上 drop table 语句,默认开启;不开启 (--skip-add-drop-table)
    -n, --no-create-db          不包含数据库的创建语句
    -t, --no-create-info        不包含数据表的创建语句
    -d --no-data                不包含数据
    -T, --tab=name             自动生成两个文件：一个.sql文件，创建表结构的语句；一
个.txt文件，数据文件
-- 可以通过如下命令查看详细用法
	mysqldump --help
12345678910111213141516171819
```

演示示例：

- 建表语句与数据备份在同一个文件
  ![在这里插入图片描述](https://img-blog.csdnimg.cn/d0c5a989d712469c92f22604fffd1d69.png)
- 建表语句与数据备份在不同文件

1. 直接执行会出错，数据不能完成备份，原因是因为我们所指定的数据存放目录/root，MySQL认 为是不安全的，需要存储在MySQL信任的目录下。

![在这里插入图片描述](https://img-blog.csdnimg.cn/63f13ed1fc9b43ec91c3b7f27db26ce2.png)

1. 按照错误提示，可以查看一下系统变量 `secure_file_priv` 。

![在这里插入图片描述](https://img-blog.csdnimg.cn/e857ec56058b4b608f13658a51ad972a.png)

1. 备份到变量所指定的路径即可

![在这里插入图片描述](https://img-blog.csdnimg.cn/1ac79c779f3d4ba2ace36db5c720dd0a.png)

1. 上述的两个文件 score.sql 中记录的就是表结构文件，而 score.txt 就是表数据文件，但是需要注意表数据文件，并不是记录一条条的insert语句，而是按照一定的格式记录表结构中的数据。如下：

![在这里插入图片描述](https://img-blog.csdnimg.cn/4b31b141632848acbdeaf34aff69c7a3.png)

## mysqlimport

**用途**：mysqlimport 是客户端数据导入工具，用来导入mysqldump 加 `-T` 参数后导出的`txt`文件

```sql
-- 语法 ：    
	mysqlimport [options]  db_name  textfile1  [textfile2...]
-- 可以通过如下命令查看详细用法
	mysqlimport --help
1234
```

演示示例：

![在这里插入图片描述](https://img-blog.csdnimg.cn/520417fbc2ff4abd9f04e80e067a22ea.png)

## source

**用途**：source指令用来导入sql文件.需要在mysql命令行中执行。

```sql
-- 语法 ：    
	source 文件路径/xxxxx.sql
12
```

演示示例：

![在这里插入图片描述](https://img-blog.csdnimg.cn/532720f804f4477db84a342e0697e622.png)

