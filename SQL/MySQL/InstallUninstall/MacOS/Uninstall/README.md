# 卸载

停止MySQL服务。打开终端，运行命令：

```shell
sudo launchctl unload -F /Library/LaunchDaemons/com.oracle.oss.mysql.mysqld.plist
```

或在设置中停止服务：

![image-20240704221823340](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042218735.png)

查看MySQL路径：

```shell
brew list | grep mysql
```

运行命令卸载MySQL软件：

```shell
brew uninstall mysql
```

或在设置中卸载：

![image-20240704222011818](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042220328.png)

删除MySQL数据文件夹，运行以下命令：删除MySQL的数据文件

```shell
sudo rm -rf /usr/local/var/mysql
```

清除MySQL配置文件：清除MySQL的配置文件

```shell
sudo rm -rf /etc/my.cnf
```

清理brew缓存

```shell
brew cleanup
```

