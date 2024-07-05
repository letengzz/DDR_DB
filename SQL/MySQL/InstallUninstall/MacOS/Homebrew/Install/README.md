# Homebrew 安装

1、Homebrew：Homebrew 是一种包管理器，它能够为系统提供许多软件包的管理能力。

2、Xcode 命令行工具：Xcode 命令行工具是一种开发工具软件包，它能够为系统提供一些开发工具所需的命令工具。

****

打开终端(Terminal)，使用Homebrew安装MySQL：

```shell
brew install mysql
```

启动MySQL：

```shell
mysql.server start
```

检查MySQL是否已经安装成功：

```shell
mysql --version
```

![image-20231214224051419](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042246041.png)

停止mysql服务，在终端输入以下指令：

```shell
cd /usr/local/mysql/bin 
sudo ./mysqld_safe --skip-grant-tables
Password: # 输入 Mac 用户的密码
```

