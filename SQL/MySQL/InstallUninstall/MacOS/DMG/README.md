# 安装包 安装

## 安装MySQL

下载地址：https://dev.mysql.com/downloads/mysql/

**说明**："GA" 是 "General Availability" 的缩写，通常表示软件的正式发布版本，即最新的稳定版本。

![image-20240704201822707](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042245456.png)

双击mysql8的安装向导：

![1703050965495](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042200639.png)

安装和密码配置：

![1703051078057](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042201603.png)

配置信息：

![1703051193588](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042201527.png)

![1703051261547](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042202121.png)

## MySQL数据库服务的启动和停止

MySQL软件的服务器端必须先启动，客户端才可以连接和使用使用数据库。

如果接下来天天用，可以设置自动启动。

* 打开Mac系统设置

* 找到mysql服务

  ![1703051722457](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042202272.png)

## MySQL数据库环境变量的配置

打开终端，输入mysql，下面情况证明MYSQL环境变量问题！

![image-20240704220422547](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042204138.png)

打开终端配置MySQL环境：[mac环境变量文件在登录用户文件夹下/.bash_profile]

```shell
vim ~/.bash_profile
```

```shell
vim ~/.zshrc
```

按字母 i 键切换至输入状态，添加如下配置：mysql默认安装到/usr/local/mysql文件夹，将其bin，配置到path变量

```shell
export PATH=${PATH}:/usr/local/mysql/bin
```

按ESC键退出输入状态，输入:wq回车即可

然后执行 `source .bash_profile` 使其配置生效。

```shell
source ~/.bash_profile
```

```shell
source ~/.zshrc
```

输入`mysql --version`，出现MySQL版本信息，则表示配置成功。

```shell
mysql --version
```

