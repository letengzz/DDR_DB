# 数据控制语言 DCL

**数据控制语言 DCL**(`Data Control Language`)：**用来管理数据库用户、控制数据库的访问权限**

## 管理用户

### 查询用户

使用 `SELECT * FROM mysql.user;` 查询用户信息

```mysql
SELECT * FROM mysql.user;
```

- Host代表当前用户访问的主机, 如果为localhost, 代表只能够在当前本机访问，不可以远程访问的
- User代表的是访问该数据库的用户名。在MySQL中需要**通过Host和User来唯一标识一个用户**

![image-20230910153312845](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309101533490.png)

### 创建用户

使用 `CREATE USER '用户名'@'主机名' IDENTIFIED BY '密码';` 来创建用户

```mysql
CREATE USER '用户名'@'主机名' IDENTIFIED BY '密码';
```

**例**：

```mysql
CREATE USER 'hjc'@'localhost' IDENTIFIED BY '123123';
```

![image-20230910154217805](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309101548542.png)

### 修改用户密码

使用 `ALTER USER '用户名'@'主机名' IDENTIFIED WITH mysql_native_password BY '新密码';` 修改用户密码

```mysql
ALTER USER '用户名'@'主机名' IDENTIFIED WITH mysql_native_password BY '新密码';
```

**例**：

```mysql
ALTER USER 'hjc'@'localhost' IDENTIFIED WITH mysql_native_password BY 'hjc123';
```

### 删除用户

使用 `DROP USER '用户名'@'主机名'; ` 来删除用户

```mysql
DROP USER '用户名'@'主机名'; 
```

**例**：

```mysql
DROP USER 'hjc'@'localhost'; 
```

![image-20230910154747322](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309101547249.png)

## 权限控制

**常见权限**：

![image-20230910155240526](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309101552443.png)

**注意**：

- 多个权限之间，使用逗号分隔
- 授权时， 数据库名和表名可以使用 `*` 进行通配，代表所有

### 查询用户权限

使用 `SHOW GRANTS FOR '用户名'@'主机名' ;` 查询用户权限

```mysql
SHOW GRANTS FOR '用户名'@'主机名';
```

**例**：

```mysql
SHOW GRANTS FOR 'hjc'@'localhost';
```

![image-20230910155651627](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309101556751.png)

### 授予权限

使用 `GRANT 权限列表 ON 数据库名.表名 TO '用户名'@'主机名';` 授予权限

```mysql
GRANT 权限列表 ON 数据库名.表名 TO '用户名'@'主机名';
```

**例**：

```mysql
GRANT INSERT,SELECT ON sql_test.* TO 'hjc'@'localhost';
```

![image-20230910160248726](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309101602457.png)

### 撤销权限

使用 `REVOKE 权限列表 ON 数据库名.表名 FROM '用户名'@'主机名';` 撤销权限

```mysql
REVOKE 权限列表 ON 数据库名.表名 FROM '用户名'@'主机名';
```

**例**：

```mysql
REVOKE INSERT ON sql_test.* FROM 'hjc'@'localhost';
```

![image-20230910160427375](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img/Java/202309101604952.png)