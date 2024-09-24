# ElasticSearch-head

ElasticSearch是一个基于Lucene的搜索服务器。它提供了一个分布式多用户能力的全文搜索引擎，基于RESTful web接口。Elasticsearch是用Java开发的，并作为Apache许可条款下的开放源码发布，是当前流行的企业级搜索引擎。  

ElasticSearch-head就是一款能连接ElasticSearch搜索引擎，并提供可视化的操作页面对ElasticSearch搜索引擎进行各种设置和数据检索功能的管理插件，如在head插件页面编写RESTful接口风格的请求，就可以对ElasticSearch中的数据进行增删改查、创建或者删除索引等操作。类似于使用navicat工具连接MySQL这种关系型数据库，对数据库做操作。

## 通过浏览器添加插件 

通过chrome安装插件的方式提供一个可操作es的图形化界面。

在chrome 浏览器中，通过“扩展程序” 添加 elasticsearch head 插件的方式，这种方式无须开启 ES 的跨域访问。

谷歌浏览器访问：https://chromewebstore.google.com/detail/multi-elasticsearch-head/cpmmilfkofbeimbmgiclohpodggeheim?hl=zh-CN&utm_source=ext_sidebar

![image-20231229111312218](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312291113155.png)

![image-20231229111631286](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312291116990.png)

![image-20231229111724615](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312291117849.png)

![image-20231229111810080](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312291118699.png)

点击New，输入URI：

![image-20231229111843418](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312291118046.png)

![image-20231229112016332](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312291120559.png)

## 使用Docker安装

修改Elasticsearch：

```
docker exec -it es /bin/bash
cd config/
vi elasticsearch.yml
```

在配置文件末尾添加如下内容，重新启动elasticsearch服务

```
http.cors.enabled: true
http.cors.allow-origin: "*"
```

安装elasticsearch-head：

```
docker pull mobz/elasticsearch-head:5
```

启动：

```
docker run -d --name es-head -p 9100:9100 docker.io/mobz/elasticsearch-head:5
```

通过访问9100端口，来打开可视化head插件：

![image-20231229171235582](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312291712493.png)