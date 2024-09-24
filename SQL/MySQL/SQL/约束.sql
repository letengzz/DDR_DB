# 主键约束 建表时指定约束
CREATE TABLE test(
	id INT AUTO_INCREMENT PRIMARY KEY  COMMENT  'ID唯一标识',
	name VARCHAR(20) COMMENT  '姓名',
	test INT  COMMENT  '无约束对比测试字段'
);

# 主键约束 建表后指定约束
CREATE TABLE test(
	id int COMMENT  'ID唯一标识',
	name VARCHAR(20) COMMENT  '姓名',
	test int  COMMENT  '无约束对比测试字段'
);
ALTER TABLE test ADD PRIMARY KEY (id);
ALTER TABLE test MODIFY id int AUTO_INCREMENT;

# 主键约束 插入测试
INSERT INTO test(name) VALUES ('张三');
INSERT INTO test(name) VALUES ('李四');
SELECT * FROM test;


# 唯一约束 建表时指定约束
CREATE TABLE test(
	name VARCHAR(20) UNIQUE COMMENT  '姓名',
	test VARCHAR(20)  COMMENT  '无约束对比测试字段'
);

# 唯一约束 建表后指定约束
CREATE TABLE test(
	name VARCHAR(20) COMMENT  '姓名',
	test VARCHAR(20)  COMMENT  '无约束对比测试字段'
);
ALTER TABLE test ADD UNIQUE(name);

# 唯一约束 插入测试
INSERT INTO test VALUES ('张三','张三');
INSERT INTO test VALUES ('张三','张三');
SELECT * FROM test;

# 默认约束 建表时指定约束
CREATE TABLE test(
	name VARCHAR(20) COMMENT  '姓名',
  status char(1) DEFAULT  '1'  COMMENT  '状态',
	test INT  COMMENT  '无约束对比测试字段'
);

# 默认约束 建表后指定约束
CREATE TABLE test(
	name VARCHAR(20) COMMENT  '姓名',
  status char(1) COMMENT  '状态',
	test INT  COMMENT  '无约束对比测试字段'
);
ALTER TABLE test MODIFY status int DEFAULT '1';

# 默认约束 插入测试
INSERT INTO test(name) VALUES ('张三');
INSERT INTO test(name,status) VALUES ('李四',2);
SELECT * FROM test;

# 检查约束 建表时指定约束
CREATE TABLE test(
	name VARCHAR(20) COMMENT  '姓名',
  age INT CHECK(age > 0 && age <= 120)  COMMENT  '年龄',
	test INT  COMMENT  '无约束对比测试字段'
);

# 检查约束 建表后指定约束
CREATE TABLE test(
	name VARCHAR(20) COMMENT  '姓名',
  age INT COMMENT  '年龄',
	test INT COMMENT  '无约束对比测试字段'
);
ALTER TABLE test ADD CONSTRAINT age CHECK(age > 0 && age <= 120);

# 检查约束 插入测试
INSERT INTO test(name,age,test) VALUES ('张三',29,29);
INSERT INTO test(name,age,test) VALUES ('李四',150,150);
SELECT * FROM test;

# 非空约束 建表时指定约束
CREATE TABLE test(
	name VARCHAR(20)  NOT NULL COMMENT  '姓名' ,
	test VARCHAR(20)  COMMENT  '无约束对比测试字段'
);

# 非空约束 建表后指定约束
CREATE TABLE test(
	name VARCHAR(20) COMMENT  '姓名' ,
	test VARCHAR(20)  COMMENT  '无约束对比测试字段'
);
ALTER TABLE test MODIFY name VARCHAR(20) NOT NULL;

# 非空约束 插入测试
INSERT INTO test(name,test) VALUES (null,null);
INSERT INTO test(name,test) VALUES ('张三','张三');
SELECT * FROM test;
