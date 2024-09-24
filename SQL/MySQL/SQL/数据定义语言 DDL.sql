# 创建名为sql_test的数据库
CREATE DATABASE sql_test;

# 创建名为sql_test的数据库不存在则创建 否则不创建
CREATE DATABASE IF NOT EXISTS sql_test;

# 创建字符集为utf8mb4 名为sql_test2的数据库
CREATE DATABASE sql_test2 DEFAULT CHARSET utf8mb4;

# 删除名为 sql_test的数据库
DROP DATABASE sql_test;

# 删除名为 sql_test的数据库存在则删除
DROP DATABASE IF EXISTS sql_test;

# 查询所有数据库
SHOW DATABASES;

# 查询当前所在的数据库
SELECT DATABASE();

# 切换数据库
use sql_test

# 创建用户记录账号密码的表
CREATE TABLE user(
  id int COMMENT '编号',
  username varchar(50) COMMENT '用户名',
  password varchar(50) COMMENT '密码'
) COMMENT '账号密码表';

# 1.为user表添加一个int类型的名为vip的字段
ALTER TABLE user ADD vip int COMMENT '是否为VIP用户';
# 2.查询表结构
DESC user;

# 查询当前数据库所有表
SHOW TABLES;

# 查询指定表结构
DESC user;

# 查询指定表的建表语句
SHOW CREATE TABLE user;

# 将vip字段的类型修改为varchar
ALTER TABLE user MODIFY vip varchar(20);

# 将字段vip名称修改为isVip 数据类型修改为int 
ALTER TABLE user CHANGE vip isVip int;

# 修改user表名修改为new_user
ALTER TABLE user RENAME TO new_user;

# 删除名为isVip的字段
ALTER TABLE new_user DROP isVip;

# 删除名叫new_user的表 存在则删除
DROP TABLE IF EXISTS new_user;

# 删除并 重新创建该表
TRUNCATE TABLE user;