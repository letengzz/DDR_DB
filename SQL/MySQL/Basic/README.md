# MySQL 基础命令

打开cmd命令窗口，连接MySQL服务命令：

```sql
mysql -u <username> -p<password> -h <hostname> <databasename>
```

参数：

- ` -u <username>`：用于指定要连接的 MySQL 数据库的用户名。    
- `-p<password>`：表示密码，后面紧跟着密码，中间没有空格。如果你不希望在命令行中显示密码，可以不指定密码，直接 -p，然后在提示下手动输入密码。    
- `-h <hostname>`：用于指定 MySQL 服务器的主机名或者 IP 地址。如果 MySQL 在本地运行，可以用 localhost。    
- `-P <port>`：用于指定连接 MySQL 服务器的端口号，默认情况下是 3306。   
- `<databasename>`：要连接的数据库的名称。连接后会默认使用这个数据库。