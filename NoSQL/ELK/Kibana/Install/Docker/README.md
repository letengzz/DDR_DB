# Docker 安装 Kibana

kibana可以提供一个Elasticsearch的可视化界面。

## 加载镜像

**注意**：Kibana版本要与Elasticsearch的版本保持一致。

在线pull：

```docker
docker pull kibana:7.12.1
```

下载后加载：https://www.elastic.co/cn/downloads/past-releases#kibana

```docker
# 导入数据
docker load -i kibana.tar
```

## 运行

运行docker命令，部署Kibana：

```docker
docker run -d \
--name kibana \
-e ELASTICSEARCH_HOSTS=http://es:9200 \
--network=es-net \
-p 5601:5601  \
kibana:7.12.1
```

- `--network es-net` ：加入一个名为es-net的网络中，与elasticsearch在同一个网络中
- `-e ELASTICSEARCH_HOSTS=http://es:9200"`：设置elasticsearch的地址，因为kibana已经与elasticsearch在一个网络，因此可以用容器名直接访问elasticsearch
- `-p 5601:5601`：端口映射配置

**说明**：若出现错误：

![image-20240109234845537](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202401092348278.png)

重启docker即可：

```
systemctl restart docker
```

具体原因：docker服务启动时定义的自定义链DOCKER被某种原因清除，但是重启docker容器的时候他会自动去生成

Kibana启动一般比较慢，需要多等待一会，可以通过命令查看运行日志，当查看到下面的日志，说明成功：

```docker
docker logs -f kibana
```

![image-20231228180548417](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312281805788.png)

此时，在浏览器输入地址访问：http://ip:5601，即可看到欢迎界面，选择 `Explore on my own`：

![image-20231228112756903](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312281128011.png)

## 基本使用

### DevTools

Kibana中提供了一个DevTools界面：

![image-20231228180913602](assets/image-20231228180913602.png)

可以编写DSL来操作elasticsearch。并且对DSL语句有自动补全功能。

![image-20231228181024367](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312281810457.png)

模拟请求：

![image-20231228181107400](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312281811108.png)

**DevTools 作用**：帮助发送DSL语句，本质就是发送一个Restful的请求到 Elasticsearch中
