# Elastic Stack

ELK是包含但不限于Elasticsearch (简称es)、Logstash、Kibana 三个开源软件的组成的一个整体。这三个软件合成ELK。是用于数据抽取 ([Logstash](Logstash/README.md))、搜索分析 ([Elasticsearch](Elasticsearch/README.md))、数据展现 ([Kibana](Kibana/README.md)) 的一整套解决方案，所以也称作`ELK stack`。

- [Elastic Stack概述](Introduce/README.md)

**Elasticsearch**：

- [Elasticsearch 概述](Elasticsearch/Introduce/README.md)
- [Elasticsearch 核心概念](Elasticsearch/CoreConcept/README.md)
- [Elasticsearch 安装](Elasticsearch/Install/README.md)
- [Elasticsearch 基础使用](Elasticsearch/BasicOperation/README.md)

> 基本使用：默认分词器、常见mapping映射属性、索引库操作、文档操作

- [Elasticsearch 分词器](Elasticsearch/Tokenizer/README.md)
- Elasticsearch 内部机制
- Elasticsearch 核心概念
- Elasticsearch7 SQL新特性
- [Elasticsearch 可视化工具](Elasticsearch/VisualTool/README.md)

**Kibana**：

- [Kibana 安装](Kibana/Install/README.md)

**插件**：

- [fscrawler 文档爬虫](Expand/fscrawler/README.md)

**拓展**：

- [Elasticsearch Java操作](Java/README.md)
- [Elasticsearch SpringBoot操作]()

## 同义词

```
"analysis": {
      
      "analyzer": {
        "fscrawler_path": {
          "tokenizer": "fscrawler_path"
        },
        "ik_synonyms_search_analyzer": {
          "tokenizer": "ik_max_word",
          "filter": [
            "lowercase",
            "ik_synonyms_filter"
          ]
        },
        "completion_analyzer": {
          "tokenizer": "ik_max_word",
          "filter": "py"
        }
      },
      "tokenizer": {
        "fscrawler_path": {
          "type": "path_hierarchy"
        }
      }
    }
```



https://www.bilibili.com/video/BV1qe411L7SJ/?spm_id_from=333.337.search-card.all.click&vd_source=5071570e49144415dd3e032db49e860b

![image-20240105155653655](assets/image-20240105155653655.png)

![image-20240105155750665](assets/image-20240105155750665.png)

![image-20240105155806350](assets/image-20240105155806350.png)

![image-20240105155921642](assets/image-20240105155921642.png)

![image-20240105160430720](assets/image-20240105160430720.png)

![image-20240105160443292](assets/image-20240105160443292.png)

![image-20240105160447545](assets/image-20240105160447545.png)

![image-20240105163739610](assets/image-20240105163739610.png)

![image-20240105163822252](assets/image-20240105163822252.png)



![image-20240105163652464](assets/image-20240105163652464.png)

![image-20240105162816140](assets/image-20240105162816140.png)

![image-20240105160542840](assets/image-20240105160542840.png)

![image-20240105160547277](assets/image-20240105160547277.png)

![image-20240105163843134](assets/image-20240105163843134.png)

![image-20240105160615654](assets/image-20240105160615654.png)

![image-20240105160747613](assets/image-20240105160747613.png)

![image-20240105160851799](assets/image-20240105160851799.png)

![image-20240105160930390](assets/image-20240105160930390.png)

![image-20240105160953293](assets/image-20240105160953293.png)

![image-20240105161107076](assets/image-20240105161107076.png)

![image-20240105161146944](assets/image-20240105161146944.png)

![image-20240105161200638](assets/image-20240105161200638.png)

![image-20240105161216813](assets/image-20240105161216813.png)

![image-20240105161428408](assets/image-20240105161428408.png)

![image-20240105161507022](assets/image-20240105161507022.png)

![image-20240105170308636](assets/image-20240105170308636.png)

![image-20240105161612419](assets/image-20240105161612419.png)

![image-20240105161628682](assets/image-20240105161628682.png)

![image-20240105161731597](assets/image-20240105161731597.png)

![image-20240105161741293](assets/image-20240105161741293.png)

## 拼写纠错





```
docker run -it --rm -v ~/.fscrawler:/root/.fscrawler -v ~/tmp/docs:/tmp/es:ro dadoonet/fscrawler fscrawler shuto_fs
```

```
# 创建工作目录
mkdir -p ~/shuto/fscrawler
# 创建文档目录 即要被摄入的文档位置
mkdir -p ~/shuto/disk/es-docs
```

```
docker run -it -d --name fscrawler -v /shuto/fscrawler:/root/.fscrawler -v /shuto/disk/es-docs:/tmp/es:ro dadoonet/fscrawler:2.9 fscrawler shuto_fs
```



```
docker run -it --rm --name fscrawler -v /shuto/fscrawler:/root/.fscrawler -v /shuto/disk/es-docs:/tmp/es:ro dadoonet/fscrawler:2.9 fscrawler shuto_fs
```

![image-20240103091632321](assets/image-20240103091632321.png)

**注意**：使用docker不需要更改url  由于做了数据卷 自动会映射到该默认路径

- path：路径信息
  - virtual 文件名
  - root 类似与md5值
  - real 全路径
- file：
  - extension 拓展名
  - last accessed 最后访问的时间

文件夹的信息：文档信息的路径信息

![image-20240103102507932](assets/image-20240103102507932.png)



## RestClient

![image-20231229102711569](assets/image-20231229102711569.png)

![image-20231229102724041](assets/image-20231229102724041.png)

![image-20231229102819875](assets/image-20231229102819875.png)

![image-20231229102930387](assets/image-20231229102930387.png)

![image-20231229102950296](assets/image-20231229102950296.png)

![image-20231229103005628](assets/image-20231229103005628.png)

![image-20231229103047152](assets/image-20231229103047152.png)

![image-20231229103322103](assets/image-20231229103322103.png)

![image-20231229103432753](assets/image-20231229103432753.png)

![image-20231229103528238](assets/image-20231229103528238.png)

![image-20231229103537340](assets/image-20231229103537340.png)

![image-20231229103558343](assets/image-20231229103558343.png)

## 全文检索查询

![image-20231229103730731](assets/image-20231229103730731.png)

![image-20231229103753671](assets/image-20231229103753671.png)

![image-20231229103802100](assets/image-20231229103802100.png)

抽取相同代码：

idea Ctrl alt m

![image-20231229103913728](assets/image-20231229103913728.png)

![image-20231229103921849](assets/image-20231229103921849.png)

![image-20231229103936040](assets/image-20231229103936040.png)

![image-20231229103950202](assets/image-20231229103950202.png)

## 精确查询

![image-20231229104008765](assets/image-20231229104008765.png)

![image-20231229104032019](assets/image-20231229104032019.png)

![image-20231229104702521](assets/image-20231229104702521.png)

![image-20231229104707191](assets/image-20231229104707191.png)



![image-20231229104719827](assets/image-20231229104719827.png)

![image-20231229104735073](assets/image-20231229104735073.png)

![image-20231229104756544](assets/image-20231229104756544.png)

## 排序和分页

![image-20231229104852190](assets/image-20231229104852190.png)

分页 链式调用

![image-20231229105054413](assets/image-20231229105054413.png)

![image-20231229105047218](assets/image-20231229105047218.png)

![image-20231229105116770](assets/image-20231229105116770.png)

## 高亮显示

![image-20231229105213567](assets/image-20231229105213567.png)

![image-20231229105320185](assets/image-20231229105320185.png)

![image-20231229105342803](assets/image-20231229105342803.png)

![image-20231229105450097](assets/image-20231229105450097.png)

![image-20231229105646044](assets/image-20231229105646044.png)

![image-20231229105656136](assets/image-20231229105656136.png)

![image-20231229105708213](assets/image-20231229105708213.png)

# 智能补全技术

![image-20240108145221402](assets/image-20240108145221402.png)

![image-20240108145225639](assets/image-20240108145225639.png)

![image-20240108145232704](assets/image-20240108145232704.png)

![image-20240108145237080](assets/image-20240108145237080.png)

![image-20240108145240666](assets/image-20240108145240666.png)

![image-20240108145257569](assets/image-20240108145257569.png)

![image-20240108145312376](assets/image-20240108145312376.png)

![image-20240108145346384](assets/image-20240108145346384.png)

![image-20240108145411881](assets/image-20240108145411881.png)

![image-20240108145424370](assets/image-20240108145424370.png)

![image-20240108145505442](assets/image-20240108145505442.png)

![image-20240108145513308](assets/image-20240108145513308.png)

![image-20240108151234463](assets/image-20240108151234463.png)

![image-20240108151414047](assets/image-20240108151414047.png)

![image-20240108151422981](assets/image-20240108151422981.png)

![image-20240108151519213](assets/image-20240108151519213.png)

![image-20240108151738423](assets/image-20240108151738423.png)

## 自定义分词器

![image-20240108152000896](assets/image-20240108152000896.png)

![image-20240108152119722](assets/image-20240108152119722.png)



![image-20240108152157630](assets/image-20240108152157630.png)

![image-20240108152222943](assets/image-20240108152222943.png)

只对当前库有效

![image-20240108152442485](assets/image-20240108152442485.png)

![image-20240108153102287](assets/image-20240108153102287.png)

![image-20240108153232689](assets/image-20240108153232689.png)

![image-20240108153314752](assets/image-20240108153314752.png)

![image-20240108153358433](assets/image-20240108153358433.png)

![image-20240108153405102](assets/image-20240108153405102.png)

![image-20240108153508289](assets/image-20240108153508289-17046993085921.png)

![image-20240108153516260](assets/image-20240108153516260.png)

## 自动补全

![image-20240108153535400](assets/image-20240108153535400.png)

![image-20240108153656940](assets/image-20240108153656940.png)

![image-20240108153938542](assets/image-20240108153938542.png)

![image-20240108153948719](assets/image-20240108153948719.png)

![image-20240108154338681](assets/image-20240108154338681.png)

![image-20240108154352434](assets/image-20240108154352434.png)

![image-20240108154629628](assets/image-20240108154629628.png)

![image-20240108154739440](assets/image-20240108154739440.png)

![image-20240108154929873](assets/image-20240108154929873.png)

![image-20240108155059719](assets/image-20240108155059719.png)

![image-20240108155441438](assets/image-20240108155441438.png)

![image-20240108155606103](assets/image-20240108155606103.png)

![image-20240108155725855](assets/image-20240108155725855.png)

## RESTAPI自动补全

![image-20240108155803636](assets/image-20240108155803636.png)

![image-20240108155946388](assets/image-20240108155946388.png)

![image-20240108160244373](assets/image-20240108160244373.png)

![image-20240108160448302](assets/image-20240108160448302.png)

![image-20240108160701275](assets/image-20240108160701275.png)

![image-20240108160824241](assets/image-20240108160824241.png)



![image-20240108160918634](assets/image-20240108160918634.png)

![image-20240108161020319](assets/image-20240108161020319-17047014207133.png)

![image-20240108161036083](assets/image-20240108161036083.png)

![image-20240108161129799](assets/image-20240108161129799.png)

![image-20240108161211331](assets/image-20240108161211331.png)

## 备份数据

```java
/**
 * ES 配置类
 * @author hjc
 */
//@Configuration
public class ElasticsearchConfig {
    @Value("${shuto.elasticsearch.host-list}")
    private String hostList;

    @Bean(destroyMethod = "close")
    public RestHighLevelClient restHighLevelClient(){
        String[] split = hostList.split(",");
        HttpHost[] httpHostsArray = new HttpHost[split.length];
        for (int i = 0; i < split.length; i++) {
            String item=split[i];
            httpHostsArray[i]=new HttpHost(item.split(":")[0],Integer.parseInt(item.split(":")[1]),"http");
        }
        return new RestHighLevelClient(RestClient.builder(httpHostsArray));
    }

}
```

