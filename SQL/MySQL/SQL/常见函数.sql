-- 常见字符串函数

# 字符串拼接
SELECT CONCAT('Hello，',name) FROM emp;

# 全部转小写
SELECT LOWER('Hello');

# 全部转大写
SELECT UPPER('Hello');

# 左填充
SELECT LPAD(name,5,'*') FROM emp;

# 右填充
SELECT RPAD(name,5,'*') FROM emp;

# 去除空格
SELECT TRIM('            Hello  MySQL ');

# 截取子字符串
SELECT SUBSTRING(name,1,1) FROM emp;

-- 常见数值函数

# 向上取整
SELECT CEIL(1.1);

# 向下取整
SELECT FLOOR(1.9);

# 取模
SELECT MOD(7,4);

# 获取随机数
SELECT RAND();

# 四舍五入
SELECT ROUND(2.344,2);

-- 常见日期函数

# 当前日期
SELECT CURDATE();

# 当前时间
SELECT CURTIME();

# 当前日期和时间
SELECT NOW();

# 当前年、月、日
SELECT YEAR(NOW());
SELECT MONTH(NOW());
SELECT DAY(NOW());


# 增加指定的时间间隔
SELECT DATE_ADD(NOW(),INTERVAL 70 YEAR);

# 获取两个日期相差的天数
SELECT DATEDIFF(NOW(),'2023-1-1');

-- 流程函数

# if 实例
SELECT IF(FALSE,'Success','Error');

# ifnull 实例
SELECT IFNULL('ok','Default');
SELECT IFNULL(null,'Default');

# CASE [ expr ] WHEN [ val1 ] THEN [res1] ... ELSE [ default ] END 示例
SELECT name,(CASE workaddress	WHEN '北京' THEN '一线城市'	WHEN '上海' THEN '一线城市'
	WHEN '广州' THEN '一线城市' ELSE '二线城市' END) AS '工作地址'
 FROM emp;

# CASE WHEN [ val1 ] THEN [res1] ... ELSE [ default ] END 示例
SELECT name,
(CASE WHEN age >= 20 THEN '年轻人' WHEN age >= 40 THEN '中年人' ELSE '老年人' END ) AS 年龄 
FROM emp;