# 查询用户信息
SELECT * FROM mysql.user

# 创建用户
CREATE USER 'hjc'@'localhost' IDENTIFIED BY '123123';

# 修改用户密码
ALTER USER 'hjc'@'localhost' IDENTIFIED WITH mysql_native_password BY 'hjc123';

# 删除用户
DROP USER 'hjc'@'localhost'; 

# 查询用户权限
SHOW GRANTS FOR 'hjc'@'localhost' ;

# 授予权限
GRANT INSERT,SELECT ON sql_test.* TO 'hjc'@'localhost';

# 撤销权限
REVOKE INSERT ON sql_test.* FROM 'hjc'@'localhost';
