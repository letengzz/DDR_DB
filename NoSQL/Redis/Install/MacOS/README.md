# MacOS 安装

## 通过Brew安装

安装：

```brew
brew install redis
```

启动：

1. 后台启动，不会看到 Redis 界面 

   ```brew
   brew services start redis
   ```

2. 有背景启动(配置文件在/opt/homebrew/etc/redis.conf，也有的机器在/usr/local/etc/redis.conf)

   ```
   redis-server /usr/local/etc/redis.conf
   ```

启动Redis服务端：

```redis
redis-server
```

启动Redis客户端：

```redis
redis-cli
```

连接：打开新命令行输入 `redis-cli -h 127.0.0.1 -p 6379` #-h是主机，端口默认 6379

```redis
redis-cli -h 127.0.0.1 -p 6379 
```

关闭：

```redis
redis-cli SHUTDOWN
```

如果是 brew services start redis，必须通过brew services stop redis关闭：

```brew
brew services stop redis
```

## 官网安装

在[官方网站](https://redis.io/download/)中下载即可：

![image-20240309184632287](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202403091846901.png)

## 修改配置文件

打开配置文件：配置文件在/opt/homebrew/etc/redis.conf，也有的机器在/usr/local/etc/redis.conf

```
vi /usr/local/etc/redis.conf
```

默认`daemonize no` 改为 `daemonize yes`：设置后台启动

![image-20240501154741763](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202405011549237.png)

默认`protected-mode yes` 改为 `protected-mode no`：关闭保护模式

![image-20240501155013907](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202405011550462.png)

添加redis密码 改为 requirepass 你自己设置的密码

![image-20240501155143447](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202405011551891.png)

启动Redis服务端：

```redis
redis-server /usr/local/etc/redis.conf
```

