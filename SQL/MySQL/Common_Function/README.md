# 常用函数

MySQL中的函数是官方封装好的，可以直接调用的一段代码。使用函数可以快速便捷的完成一些需求，例如统计一些拼接字符串，对数值进行取值处理、日期操作等等。

MySQL官方文档：https://dev.mysql.com/doc/refman/8.0/en/functions.html

## 常见聚合函数

![image-20230911152454533](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309111524031.png)

- 详见 [聚合函数查询](../Basis/Statement/DQL.md#聚合函数查询)

## 常见字符串函数

![image-20230911162545414](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309111907438.png)

**例**：

- 字符串拼接：

  ```mysql
  SELECT CONCAT('Hello，',name) FROM emp;
  ```

  ![image-20230911191246689](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309111912854.png)

- 全部转小写：

  ```mysql
  SELECT LOWER('Hello');
  ```

  ![image-20230911191553530](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309111915079.png)

- 全部转大写：

  ```mysql
  SELECT UPPER('Hello');
  ```

  ![image-20230911191617441](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309112054131.png)

- 左填充：

  ```mysql
  SELECT LPAD(name,5,'*') FROM emp;
  ```

  ![image-20230911192037263](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309112054445.png)

- 右填充：

  ```mysql
  SELECT RPAD(name,5,'*') FROM emp;
  ```

  ![image-20230911192018323](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309111920928.png)

- 去除空格：

  ```mysql
  SELECT TRIM('            Hello  MySQL ');
  ```

  ![image-20230911191856858](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309111920200.png)

- 截取子字符串：

  ```mysql
  SELECT SUBSTRING(name,1,1) FROM emp;
  ```

  ![image-20230911192002731](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309112054645.png)

## 常见数值函数

![image-20230911163208356](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309111908644.png)

**例**：

- 向上取整：

  ```mysql
  SELECT CEIL(1.1);
  ```

  ![image-20230911204202363](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309112042830.png)

- 向下取整：

  ```mysql
  SELECT FLOOR(1.9);
  ```

  ![image-20230911204232528](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309112042291.png)

- 取模：

  ```mysql
  SELECT MOD(7,4);
  ```

  ![image-20230911204248841](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309112042366.png)

- 获取随机数：

  ```mysql
  SELECT RAND();
  ```

  ![image-20230911204301725](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309112043402.png)

- 四舍五入：

  ```mysql
  SELECT ROUND(2.344,2);
  ```

  ![image-20230911204315304](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309112043959.png)

## 常见日期函数

![image-20230911163649187](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309111908358.png)

**例**：

- 当前日期：

  ```mysql
  SELECT CURDATE();
  ```

  ![image-20230911204657547](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309112046780.png)

- 当前时间：

  ```mysql
  SELECT CURTIME();
  ```

  ![image-20230911204706675](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309112047004.png)

- 当前日期和时间：

  ```mysql
  SELECT NOW();
  ```

  ![image-20230911204716417](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309112047648.png)

- 当前年、月、日：

  ```mysql
  SELECT YEAR(NOW());
  SELECT MONTH(NOW());
  SELECT DAY(NOW());
  ```

  ![image-20230911204640209](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309112046805.png)

- 增加指定的时间间隔：

  ```mysql
  SELECT DATE_ADD(NOW(),INTERVAL 70 YEAR);
  ```

  ![image-20230911204810273](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309112048733.png)

- 获取两个日期相差的天数：

  ```mysql
  SELECT DATEDIFF(NOW(),'2023-1-1');
  ```

  ![image-20230911204837172](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309112048880.png)

## 流程函数

![image-20230911190819965](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309111908848.png)

**例**：

- `if` 示例：

  ```mysql
  SELECT IF(FALSE,'Success','Error');
  ```

  ![image-20230911205050373](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309112050730.png)

- `ifnull` 示例：

  ```mysql
  SELECT IFNULL('ok','Default');
  SELECT IFNULL(null,'Default');
  ```

  ![image-20230911205113369](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309112051987.png)

- `CASE [ expr ] WHEN [ val1 ] THEN [res1] ... ELSE [ default ] END `示例：

  ```mysql
  SELECT name,
  (CASE workaddress	WHEN '北京' THEN '一线城市'	WHEN '上海' THEN '一线城市'
  	WHEN '广州' THEN '一线城市' ELSE '二线城市' END) AS '工作地址'
  FROM emp;
  ```

  ![image-20230911205142190](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309112053214.png)

- `CASE WHEN [ val1 ] THEN [res1] ... ELSE [ default ] END` 示例：

  ```mysql
  SELECT name,
  (CASE WHEN age >= 20 THEN '年轻人' WHEN age >= 40 THEN '中年人' ELSE '老年人' END ) AS 年龄 
  FROM emp;
  ```

  ![image-20230911205246278](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309112052670.png)