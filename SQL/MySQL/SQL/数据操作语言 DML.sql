# 为id、username字段添加值
INSERT INTO user(id,username) VALUES (1,'张三');

# 为id、username、password字段添加值
INSERT INTO user(id,username,password) VALUES (1,'张三','123');

# 为id、password字段添加值
INSERT INTO user(id,password) VALUES (1,'123');

# 为全部字段添加值
insert into user values (2,'李四','lisi');

# 批量添加多条数据
INSERT INTO user (id,username,password) VALUES (1, '张三', 'zhangsan'), (2, '李四', 'lisi'), (3, '王五','wangwu');

# 全部字段批量添加
INSERT INTO user (id,username,password) VALUES (1, '张三', 'zhangsan'), (2, '李四', 'lisi'), (3, '王五','wangwu');

# 不指定条件修改字段所属下所有值 将表中所有username、password更改
UPDATE user SET username = 'haha',password = '123123';

# 指定条件，修改符合条件字段值 修改id为1的记录
UPDATE user SET username = 'zhangsan',password = 'zs' WHERE id = 1;

# 删除id为1 的记录
DELETE FROM user WHERE id=1;

# 删除所有记录
DELETE FROM user;