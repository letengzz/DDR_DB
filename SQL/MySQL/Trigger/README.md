# 触发器

触发器是与表有关的数据库对象，作用在`insert/update/delete`语句执行之前(`BEFORE`)或之后(`AFTER`)，**自动触发并执行触发器中定义的SQL语句集合**。它可以协助应用在数据库端确保数据的完整性 , 日志记录 , 数据校验等操作 。
![在这里插入图片描述](https://img-blog.csdnimg.cn/1a7cff265b5540bfa650e98f77239590.png)

可以在触发器内定义的SQL语句中使用`OLD（原始记录）`或`NEW（新增记录）`来引用所操作行的数据。目前触发器只支持行级触发，不支持语句级触发，即每影响一行数据便会触发一次。

| 触发器类型        | NEW 和 OLD含义                                              |
| ----------------- | ----------------------------------------------------------- |
| `INSERT` 型触发器 | `NEW` 表示将要或者已经新增的数据                            |
| `UPDATE` 型触发器 | `OLD` 表示修改之前的数据 , `NEW` 表示将要或已经修改后的数据 |
| `DELETE` 型触发器 | `OLD` 表示将要或者已经删除的数据                            |

![在这里插入图片描述](https://img-blog.csdnimg.cn/bddafdb52a144a17a7ee53380dffaea3.png)

## 创建触发器

- 语法

```sql
CREATE TRIGGER 触发器名称 
BEFORE/AFTER  INSERT/UPDATE/DELETE
ON 表名 FOR EACH ROW  
BEGIN
 -- SQL语句 ;
END;
```

![在这里插入图片描述](https://img-blog.csdnimg.cn/fd3b623112aa43e5ad32fb2ebb9799d4.png)

注意事项

- 触发器中的SQL语句不能出现 `SELECT * FROM TABLE` 形式的查询 ，因为其会返回一个结果集 ，使用时会抛出错误`Not allowed to return a result set from a trigger`，可以使用`SELECT INTO` 为变量设置值。
- 在使用插入/更新触发器时，**由于MySQL的写锁**，**无法在触发器内再次定义对当前表的更新或插入SQL语句**。

## 查看触发器

- 语法

```sql
SHOW TRIGGERS;
```

![在这里插入图片描述](https://img-blog.csdnimg.cn/4d1b352ecf1a41a6925bdd67596ebf4a.png)

## 删除触发器

- 语法

```sql
DROP TRIGGER [数据库名称.]触发器名称 ;  
```

如果没有指定数据库名称，默认为当前数据库 。

![在这里插入图片描述](https://img-blog.csdnimg.cn/47de57187fe640d48b8951e26b7e6a9a.png)

## 日志记录示例

使用触发器可以快捷的记录表数据变更日志。接下来我们通过触发器记录 user 表的数据变更日志，将变更日志插入到日志表user_logs中, 包含增加, 修改 , 删除，学习三种触发器的使用。

### 创建表

1. 创建 user 表以及 user_logs表

```sql
-- 用户表 user
CREATE TABLE user (
  id int NOT NULL AUTO_INCREMENT COMMENT '主键',
  name varchar(50) NOT NULL COMMENT '用户名',
  phone varchar(11) NULL COMMENT '手机号',
  email varchar(100) DEFAULT NULL COMMENT '邮箱',
  profession varchar(11) DEFAULT NULL COMMENT '专业',
  age tinyint unsigned DEFAULT NULL COMMENT '年龄',
  gender char(1) DEFAULT NULL COMMENT '性别 , 1: 男, 2: 女',
  status char(1) DEFAULT NULL COMMENT '状态',
  createtime datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4  COMMENT='用户表';


--  日志表 user_logs
  create table user_logs(
 id int(11) not null auto_increment,
 operation varchar(20) not null comment '操作类型, insert/update/delete',
 operate_time datetime not null comment '操作时间',
 operate_id int(11) not null comment '操作的ID',
 operate_params varchar(500) comment '操作参数',
 primary key(`id`)
 )engine=innodb default charset=utf8 COMMENT='用户日志表';
```

### insert型触发器

1. 创建插入`insert`型触发器

```sql
create trigger user_insert_trigger
-- 每次在user表执行完插入操作之后触发
after insert on user for each row
begin
-- 在日志表插入操作日志
-- 通过 new 可以获得新插入的数据行记录
insert into user_logs(id, operation, operate_time, operate_id, operate_params) 
VALUES
(null, 'insert', now(), new.id, concat('插入的数据内容为: id=',new.id,',name=',new.name, ', phone=',NEW.phone, ', email=', NEW.email, ', profession=', NEW.profession));
end;
```

测试：

```sql
-- 插入一条数据到user表
insert into user(id, name, phone, email, profession, age, gender, status, 
createtime) VALUES (26,'三皇子','18809091212','erhuangzi@163.com','软件工
程',23,'1','1',now());
```

![在这里插入图片描述](https://img-blog.csdnimg.cn/e7e3fa74c31a4d068feac3f770fc3186.png)

### update型触发器

1. 创建修改`update`型触发器

```sql
create trigger user_update_trigger
-- 每次在user表执行完更新操作之后触发
after update on user for each row
begin
insert into user_logs(id, operation, operate_time, operate_id, operate_params) 
VALUES
-- 在日志表插入操作日志
-- 通过 new 可以获得修改之后的数据行记录
-- 通过 old 可以获得修改之前的数据行记录
(null, 'update', now(), new.id,concat('更新之前的数据: id=',old.id,',name=',old.name, ', phone=', 
old.phone, ', email=', old.email, ', profession=', old.profession,' | 更新之后的数据: id=',new.id,',name=',new.name, ', phone=', NEW.phone, ', email=', NEW.email, ', profession=', NEW.profession));
end;
```

测试

```sql
-- 对user表执行更新操作
update user set name = '品如' where id = 26;
```

![在这里插入图片描述](https://img-blog.csdnimg.cn/12697dcba2fc4dd883621ba098105d15.png)

### delete型触发器

1. 创建删除`delete`型触发器

```sql
create trigger user_delete_trigger
-- 每次在user表执行完删除操作之后触发
after delete on user for each row
begin
insert into user_logs(id, operation, operate_time, operate_id, operate_params) 
VALUES
-- 在日志表插入操作日志
-- 通过 old 可以获得已经删除的数据行记录
(null, 'delete', now(), old.id,concat('删除之前的数据: id=',old.id,',name=',old.name, ', phone=', old.phone, ', email=', old.email, ', profession=', old.profession));
 end;
```

测试：

```sql
delete from user where name = '品如';
```

![在这里插入图片描述](https://img-blog.csdnimg.cn/ee79975a532a41348599e8ea89b39915.png)