# Docker 安装 Elasticsearch

## 部署单点Elasticsearch

### 创建网络

由于es和kibana容器互联，因此需要创建一个网络：

```docker
docker network create es-net
```

### 加载镜像

在线pull：

```docker
docker pull elasticsearch:7.12.1
```

下载后加载：

```docker
# 导入数据
docker load -i es.tar
```

### 运行

运行docker命令，部署单点Elasticsearch：

```docker
docker run -d \
	--name es \
    -e "ES_JAVA_OPTS=-Xms512m -Xmx512m" \
    -e "discovery.type=single-node" \
    -v es-data:/usr/share/elasticsearch/data \
    -v es-plugins:/usr/share/elasticsearch/plugins \
	-v es-config:/usr/share/elasticsearch/config \
    --privileged \
    --network es-net \
    -p 9200:9200 \
    -p 9300:9300 \
elasticsearch:7.12.1


docker run -it \
--name es8 \
-e "ES_JAVA_OPTS=-Xms512m -Xmx512m" \
-v es8-data:/usr/share/elasticsearch/data \
-v es8-plugins:/usr/share/elasticsearch/plugins \
-v es8-config:/usr/share/elasticsearch/config \
--net elastic \
-p 9200:9200 \
-p 9300:9300 \
elasticsearch:8.12.0
```

命令解释：

- `-e "cluster.name=es-docker-cluster"`：设置集群名称
- `-e "http.host=0.0.0.0"`：监听的地址，可以外网访问
- `-e "ES_JAVA_OPTS=-Xms512m -Xmx512m"`：内存大小
- `-e "discovery.type=single-node"`：非集群模式(单点模式)
- `-v es-data:/usr/share/elasticsearch/data`：挂载逻辑卷，绑定es的数据目录
- `-v es-logs:/usr/share/elasticsearch/logs`：挂载逻辑卷，绑定es的日志目录
- `-v es-plugins:/usr/share/elasticsearch/plugins`：挂载逻辑卷，绑定es的插件目录
- `--privileged`：授予逻辑卷访问权
- `--network es-net` ：加入一个名为es-net的网络中
- `-p 9200:9200`：端口映射配置，用于访问Elasticsearch
- `-p 9300:9300`：各个es节点容器互联的端口 

在浏览器中输入：http://ip:9200 即可看到elasticsearch的响应结果：

![image-20231228175312648](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312281753385.png)

## 部署 Elasticsearch 集群

部署es集群可以直接使用docker-compose来完成，不过要求Linux虚拟机至少有**4G**的内存空间

首先编写一个docker-compose文件：

```dockerfile
version: '2.2'
services:
  es01:
    image: docker.elastic.co/elasticsearch/elasticsearch:7.12.1
    container_name: es01
    environment:
      - node.name=es01
      - cluster.name=es-docker-cluster
      - discovery.seed_hosts=es02,es03
      - cluster.initial_master_nodes=es01,es02,es03
      - bootstrap.memory_lock=true
      - "ES_JAVA_OPTS=-Xms512m -Xmx512m"
    ulimits:
      memlock:
        soft: -1
        hard: -1
    volumes:
      - data01:/usr/share/elasticsearch/data
    ports:
      - 9200:9200
    networks:
      - elastic
  es02:
    image: docker.elastic.co/elasticsearch/elasticsearch:7.12.1
    container_name: es02
    environment:
      - node.name=es02
      - cluster.name=es-docker-cluster
      - discovery.seed_hosts=es01,es03
      - cluster.initial_master_nodes=es01,es02,es03
      - bootstrap.memory_lock=true
      - "ES_JAVA_OPTS=-Xms512m -Xmx512m"
    ulimits:
      memlock:
        soft: -1
        hard: -1
    volumes:
      - data02:/usr/share/elasticsearch/data
    networks:
      - elastic
  es03:
    image: docker.elastic.co/elasticsearch/elasticsearch:7.12.1
    container_name: es03
    environment:
      - node.name=es03
      - cluster.name=es-docker-cluster
      - discovery.seed_hosts=es01,es02
      - cluster.initial_master_nodes=es01,es02,es03
      - bootstrap.memory_lock=true
      - "ES_JAVA_OPTS=-Xms512m -Xmx512m"
    ulimits:
      memlock:
        soft: -1
        hard: -1
    volumes:
      - data03:/usr/share/elasticsearch/data
    networks:
      - elastic

volumes:
  data01:
    driver: local
  data02:
    driver: local
  data03:
    driver: local

networks:
  elastic:
    driver: bridge
```

Run `docker-compose` to bring up the cluster:

```shell
docker-compose up
```

