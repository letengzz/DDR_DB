# Linux 安装与卸载

## 安装

**说明**：Linux环境安装Redis必须先具备 [gcc编译环境](https://github.com/letengzz/LDR_Linux/tree/main/Basic/GCC/README.md)

```shell
yum -y install gcc-c++
```

**注意**：目前建议都需要升级到6.0.8版本以上。

**安装步骤**：

1. 在[官方网站](https://redis.io/)上下载并放入到Linux目录`/opt`解压

   ```shell
   tar -zxvf redis-7.0.0.tar.gz
   ```

2. 在redis目录下执行make命令：

   ```
   cd redis-7.0.0
   make && make install
   ```

3. 查看默认安装路径：

   ```
   cd usr/local/bin
   ```

   - `redis-benchmak`：性能测试工具
   - `redis-check-aof`：修复有问题的AOF文件
   - `redis-check-dump`：修复有问题的dump.rdb文件
   - `redis-cli`：客户端，操作入口
   - `redis-sentinel`：redis集群使用
   - `redis-server`：redis服务器启动命令

4. 将默认的redis.conf拷贝到自定义的路径下：

   ```
   cd /opt/redis-7.0.0
   mkdir /myredis
   cp redis.conf /myredis/redis7.conf
   ls -l /myredis/
   ```

5. 修改自定义路径下配置文件：redis7.conf配置文件，改完后确保生效，记得重启

   1. 默认`daemonize no` 改为 `daemonize yes`：设置后台启动

      ![](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404080005150.png)

   2. 默认`protected-mode yes` 改为 `protected-mode no`：关闭保护模式

      ![](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404080005209.png)

   3. 默认`bind 127.0.0.1` 改为 直接注释掉 (默认`bind 127.0.0.1`只能本机访问)或改成本机IP地址，否则影响远程IP连接

      ![](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404080006254.png)

   4. 添加redis密码 改为 requirepass 你自己设置的密码

      ![](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404080006041.png)

6. 启动服务：在/usr/local/bin目录下运行redis-server，启用/myredis目录下的redis7.conf文件

   ```shell
   cd /usr/local/bin
   redis-server /myredis/redis7.conf
   ```

   查看端口号：

   ```shell
   ps -ef|grep redis|grep -v grep
   ```

7. 连接服务：

   ```
   cd /usr/local/bin
   redis-cli -a 111111 -p 6379
   ```

   ![](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404080018002.png)

   提示：`Warning: Using a password with '-a' or '-u' option on the command line interface may not be safe.`

   warning 这串输出并不是普通输出，

   shell的标准输出包含两种：

   1. 标准输出
   2. 标准错误

   命令包含1也包含2，2即是想要去除的提示。 

   解决办法将标准错误去除即可，追加`2>/dev/null`，将标准错误丢弃即可，就没有烦人的警告了。

   ![](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404080020546.png)

8. 输入`ping`：

   ```shell
   ping
   ```

9. 查看redis版本的命令：

   ```shell
   redis-server -v
   ```

**关闭步骤**：

1. 单实例关闭：

   ```shell
   redis-cli -a 111111 shutdown
   ```

2. 多实例关闭：指定端口关闭

   ```shell
   redis-cli -p 6379 shutdown
   ```

3. 内部退出：

   ```shell
   SHUTDOWN
   quit
   ```

## 卸载

**卸载步骤**：

1. 停止redis-server服务：

   ![](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404080030295.png)

2. 删除/usr/local/lib目录下与redis相关的文件：

   ```shell
   ls -l /usr/local/bin/redis-*
   rm -rf /usr/local/bin/redis-*
   ```

   ![](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404080031390.png)
