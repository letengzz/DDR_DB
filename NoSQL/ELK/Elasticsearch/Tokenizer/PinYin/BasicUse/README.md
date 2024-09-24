# 拼音分词器

拼音搜索在中文搜索环境中是经常使用的一种功能。用户只需要输入关键字的拼音全拼或者拼音首字母，搜索引擎就可以搜索出相关结果。

**官方网站**：https://github.com/medcl/elasticsearch-analysis-pinyin

## 分词的作用

- 将文档创建倒排索引的时候，要对某个文档进行分词，把词条创建倒排索引

- 当用户搜索的时候，对输入的内容进行分词

## 安装插件

### 在线安装插件

```
# 进入容器内部
docker exec -it es /bin/bash

# 在线下载并安装
./bin/elasticsearch-plugin  install https://github.com/medcl/elasticsearch-analysis-pinyin/releases/download/v7.12.1/elasticsearch-analysis-pinyin-7.12.1.zip

#退出
exit
```

### 离线安装插件

#### 查看数据卷目录

安装插件需要知道elasticsearch的plugins目录位置，而我们用了数据卷挂载，因此需要查看elasticsearch的数据卷目录，通过下面命令查看：

```
docker volume inspect es-plugins
```

![image-20231228194409739](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312281944552.png)

说明plugins目录被挂载到了：`/var/lib/docker/volumes/es-plugins/_data `这个目录中。

#### 解压缩分词器安装包

通过：https://github.com/medcl/elasticsearch-analysis-pinyin/releases/download/v7.12.1/elasticsearch-analysis-pinyin-7.12.1.zip 下载并解压，重命名为pinyin

![image-20240106232532010](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202401062325640.png)

#### 上传到es容器的插件数据卷中

![image-20240106232740337](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202401062327053.png)

###  重启容器

```shell
# 重启容器
docker restart es
```

```sh
# 查看es日志
docker logs -f es
```

## 基本使用

```
POST /_analyze
{
  "analyzer": "pinyin",
  "text": "王府井"
}
```

![image-20240106233328845](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202401062333691.png)

```
# ①创建索引
PUT /countries
{
  "mappings": {
    "properties": {
      "name": {
        "type": "text",
        "analyzer": "pinyin"
      }
    }
  }
}

# ②写入数据
POST /_bulk
{"index": {"_index": "countries","_id":"1"}}
{"name":"中国"}
{"index": {"_index": "countries","_id":"2"}}
{"name":"美国"}
{"index": {"_index": "countries","_id":"3"}}
{"name":"俄罗斯"}


# ③检索数据
GET /countries/_search
{
  "query": {
    "match": {
      "name": "zg"
    }
  }
}
```

![image-20240106233936019](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202404091732471.png)

