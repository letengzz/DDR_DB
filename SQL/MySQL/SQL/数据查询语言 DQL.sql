-- 基础查询

# 查询指定字段
SELECT id,username FROM user;
SELECT id,username,password FROM user;

# 查询全部字段
SELECT  *  FROM  user;

# 1.不使用别名 默认字段名
SELECT  *  FROM  user;
# 2.使用 AS 设置别名
SELECT id,username AS 账号,password AS 密码 FROM user;
# 3.使用空格设置别名
SELECT id,username 账号,password 密码 FROM user;

# 查看所有记录中不重复的username以及password
SELECT  DISTINCT  username,password  FROM user;
# 查看所有记录中不重复的username
SELECT  DISTINCT  username FROM user;

-- 条件查询
# 查询年龄等于 88 的员工
SELECT * FROM emp WHERE age = 88;

# 查询年龄不等于 88 的员工
SELECT * FROM emp WHERE age != 88;
SELECT * FROM emp WHERE age <> 88;

# 查询没有身份证号的员工信息
SELECT * FROM emp WHERE idcard IS NULL;

# 查询有身份证号的员工信息
SELECT * FROM emp WHERE idcard IS NOT NULL;

# 查询年龄在15岁(包含) 到 20岁(包含)之间的员工信息
SELECT * FROM emp WHERE age >= 15 AND age <= 20;
SELECT * FROM emp WHERE age >= 15 && age <= 20;
SELECT * FROM emp WHERE age BETWEEN 15 AND 20;

# 查询年龄等于18 或 20 或 40 的员工信息
SELECT * FROM emp WHERE age = 18 OR age = 20 OR age = 40;
SELECT * FROM emp WHERE age IN (18,20,40);

# 查询姓范名字为两个字的员工信息
SELECT * FROM emp WHERE name LIKE '范_';

# 查询姓范员工信息
SELECT * FROM emp WHERE name LIKE '范%';

-- 聚合函数查询

# 统计该企业员工数量
SELECT COUNT(*) FROM emp;

# 统计的是idcard字段不为null的记录数
SELECT COUNT(idcard) FROM emp;

# 统计该企业员工的平均年龄
SELECT AVG(age) FROM emp;

# 统计该企业员工的最大年龄
SELECT MAX(age) FROM emp;

# 统计该企业员工的最小年龄
SELECT MIN(age) FROM emp;

# 统计西安地区员工的年龄之和
SELECT SUM(age) FROM emp WHERE workaddress = '西安';

-- 分组查询

# 根据性别分组，统计男性员工 和 女性员工的数量
SELECT gender,COUNT(*) FROM emp GROUP BY gender;

# 查询年龄小于45的员工，并根据工作地址分组，获取员工数量大于等于3的工作地址
SELECT workaddress,COUNT(*) address_count FROM emp WHERE age < 45 GROUP BY workaddress HAVING address_count >= 3;

# 统计各个工作地址上班的男性及女性员工的数量
SELECT workaddress,gender,COUNT(*) '数量' FROM emp GROUP BY gender,workaddress;

-- 排序查询

# 根据年龄对公司的员工进行升序排序
SELECT * FROM emp ORDER BY age ASC;
SELECT * FROM emp ORDER BY age;

# 根据年龄对公司的员工进行升序排序 , 年龄相同 , 再按照入职时间进行降序排序
SELECT * FROM emp ORDER BY age ASC,entrydate DESC;

-- 分页查询
# 查询第1页员工数据, 每页展示5条记录
SELECT * FROM emp LIMIT 0,5;
SELECT * FROM emp LIMIT 5;

# 查询第2页员工数据, 每页展示10条记录
SELECT * FROM emp LIMIT 5,5;


