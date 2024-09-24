#  基本使用

## 默认分词器

默认分词器：

```
#基础分词器
GET /_analyze
{
  "analyzer": "standard",
  "text": "use elasticsearch test"
}
```

**语法说明**：

- POST：请求方式
- /_analyze：请求路径，忽略了ip，Kibana已经帮助补充
- 请求参数，JSON风格：
  - analyzer：分词器类型，standard为默认分词器
  - text：需要分词的内容

**注意**：处理中文分词，一般会使用[IK分词器](../IK/BasicUse/README.md)

## 常见mapping属性

官方文档：https://www.elastic.co/guide/en/elasticsearch/reference/current/mapping-params.html

![image-20231228204050135](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312282040369.png)

mapping是对索引库总文档的约束。

**常见mapping属性**：

- `type`： 字段数据类型，常见的简单类型：
  - **字符串**：text (可分词的文本)、keyword (精确值，不可分词，例如：品牌、国家、ip地址)
  - **数值**：long、integer、short、byte、double、float
  - **布尔**：boolean
  - **日期**：date
  - **对象**：object
- `index`：是否创建索引，默认为true。为true 创建倒排索引，参与搜索；false 不会创建，不参与搜索
- `analyzer`：使用哪种分词器
- `properties`：该字段的子字段

**注意**：

- Elasticsearch 没有数组类型，但是允许某个字段有多个值。
- 对象可以任意嵌套属性，属于子属性(子字段)，子字段也可以参与搜索的
- 可以使用properties来指定字段的子字段。如：name中的 first name 和 last name，只有在对象嵌套的时候使用，否则不需要

## 索引库操作

Elasticsearch通过Restful请求操作索引库、文档。请求内容用DSL语句来表示。

**索引库操作**：

- 创建索引库：`PUT /索引库名`
- 查询索引库：`GET /索引库名`
- 删除索引库：`DELETE /索引库名`
- 修改索引库(添加字段)：`PUT /索引名/_mapping`

**注意**：在Elasticsearch中，索引库是不允许被修改的。当索引库创建完之后，数据结构(mapping映射)已经定义好了，Elasticsearch会基于mapping去创建倒排索引，如果修改一个字段的话 就会导致原有的倒排索引彻底失效的，所以在es中是禁止修改索引库。

### 创建索引库

创建索引库和mapping的DSL语法：

```json
PUT /索引库名称
{
  "mappings": {
    "properties": {
      "字段名": {
        "type": "text",
        "analyzer": "ik_smart"
      },
      "字段名2": {
        "type": "keyword",
        "index": "false"
      },
      "字段名3": {
        "properties": {
          "子字段": {
              "type": "keyword"
          }    
        }
      },
      // ... 略
    } 
  }
}
```

**例**：

![image-20231228213214372](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312282132942.png)

字段名和数据类型可以根据数据库来创建。是否搜索、是否分词：与业务强相关，根据业务来指定。

**注意**：

- 定义id 不能定义为long，在id这个字段都是字符串类型，又因为是个整体不可分割，将来不会分词，所以选择字符串中的keyword 类型。

  ![image-20231228234409873](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312282344948.png)

- 当多个单词构成时，使用驼峰命名

- 根据多个字段搜索，多个值在es 可以使用`copy_to`属性将当前字段拷贝到指定字段

  ![image-20231228235549954](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312282355460.png)

Elasticsearch在处理地理位置(经纬度)信息时，支持两种地理坐标数据类型：

- `geo_point`：由纬度(latitude)和经度(longitude)确定一个点。例如："32.8752345,120.2981576"
- `geo_shape`：由多个`geo_point`组成的复杂集合图形。例如一条直线："LINESTRING(-77.03653 38.897676,-77.009051 38.889939)"

### 查询索引库

**查询索引库的DSL语法**：

```
GET /索引库名
```

**例**：

![image-20231228213719418](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312282137524.png)

### 删除索引库

**删除索引库的DSL语法**：

```
DELETE /索引库名
```

**例**：

![image-20231228214337714](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312282143019.png)

### 修改索引库

索引库和mapping一旦创建无法修改，但是可以添加新的字段

**注意**：字段名不能与索引库已有字段名重复

**修改索引库的DSL语法**：

```
PUT /索引库名/_mapping
{
  "properties": {
    "新字段名": {
      "type": "integer"
    }
  }
}
```

**例**：

![image-20231228215031607](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312282150262.png)

## 文档操作

**文档操作**：

- 新增文档：`POST /索引库名/_doc/文档id {JSON文档}`
- 查询文档：`GET /索引库名/_doc/文档id`
- 删除文档：`DELETE /索引库名/_doc/文档id`
- 修改文档：
  - 全量修改：`PUT /索引库名/_doc/文档id {JSON文档}`
  - 局部修改 (增量修改)：`POST /索引库名/_update/文档id {"doc":{字段}}`

### 新增文档

**新增文档的DSL语法**：

```
POST /索引库名/_doc/文档id
{
  "字段1": "值1",
  "字段2": "值2",
  "字段3": {
    "子属性1": "值3",
    "子属性2": "值4"
  }
}
```

**例**：

![image-20231228220912487](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312282209244.png)

### 查询文档

**查询文档的DSL语法**：

```
GET /索引库名/_doc/文档id
```

**批量查询文档的DSL语法**：

```
GET /索引库名/_search
```

**说明**：

- `_index`：表示所在的库
- `_version`：版本。每做一次修改 version +1
- `_source`：插入的原始文档

**例**：

![image-20231228221056963](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312282211929.png)

当删除或查询不存在的数据时，会报404：

![image-20231228221422847](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312282214923.png)

### 删除文档

**删除文档的DSL语法**：

```
DELETE /索引库名/_doc/文档id
```

**例**：

![image-20231228221250010](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312282212572.png)

### 修改文档

**使用场景**：

- 当只更新一个字段，推荐使用局部修改

- 更新字段较多，可以使用全量修改

#### 全量修改

全量修改，会删除旧文档，添加新文档。因此，当id不存在，删除不成功，但是添加不受影响。所以这种方式既能做修改操作，也可以用作新增操作。

**全量修改文档的DSL语法**：

```
PUT /索引库名/_doc/文档id
{
  "字段1": "值1",
  "字段2": "值2",
  "字段3": {
    "子属性1": "值3",
    "子属性2": "值4"
  }
}
```

 **说明**：和新增请求一样 只不过是修改了请求方式

**例**：

![image-20231228222237847](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312282222753.png)

#### 局部修改

**局部修改文档的DSL语法**：

```
POST /索引库名/_update/文档id
{
  "doc": {
    "字段名": "新值"
  }
}
```

**例**：

![image-20231228222354416](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312282223330.png)

## 查询操作

Elasticsearch 提供了基于JSON的DSL ([Domain Specific Language](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl.html)) 来定义查询。

常见的查询类型：

- 查询所有：查询出所有数据，一般测试使用。例如：match_all
- 全文检索 (full text) 查询：利用分词器对用户输入的内容分词，然后去倒排索引库中匹配。例如：
  - match
  - multi_match
- 精确查询：根据精确词条查找数据，一般是查找keyword、数值、日期、boolean等类型字段。例如：
  - ids
  - reange
  - term
- 地理(geo)查询：根据经纬度查询，例如：
  - geo_distance
  - geo_bounding_box
- 复合(compound)查询：复合查询可以将上述各种查询条件组合起来，合并查询条件。

### 查询基本语法

查询的**基本语法**：

```
GET /indexName/_search
{
  "query": {
    "查询类型": {
      "查询条件": "条件值"
    }
  }
}
```

### 查询所有

**查询所有的DSL语法**：

```
GET /hotel/_search
{
  "query": {
    "match_all": {
    }
  }
}
```

![image-20231230141837884](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312301418793.png)

- took：花费的时间
- timed_out：是否超时
- hits：命中数据 (默认显示十条)
- total：查询的总条数
- max_score：文档相关性得分

### 全文检索查询

全文检索查询，会对用户输入内容分词，常用于搜索框搜索。

![image-20231230142300881](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312301423337.png)

#### match查询

match查询：全文检索的一种，会对用户输入内容分词，然后去倒排索引库检索。

**说明**：全部包含词的靠前，只包括一个的靠后，默认显示十条

**match查询的DSL语法**：

```
GET /indexName/_search
{
  "query": {
    "match": {
      "FIELD": "TEXT"
    }
  }
}
```

![image-20231231162431439](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312311624261.png)

- took：花费的时间
- timed_out：是否超时
- hits：命中数据 (默认显示十条)
- total：查询的总条数
- max_score：文档相关性得分

#### multi_match查询

multi_match：与match查询相似，只不过允许同时查询多个字段。

**说明**：推荐使用`copy_to`的方式。因为搜索字段越多，查询的性能越差。

**multi_match查询的DSL语法**：

```
GET /indexName/_search
{
  "query": {
    "multi_match": {
      "query": "TEXT",
      "fields": ["FIELD1","FIELD2"]
    }
  }
}
```

![image-20231231164855610](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312311648022.png)

### 精确查询

精确查询一般是查找id、keyword、数值、日期、boolean等类型字段。所以不会对搜索条件分词。

**常见精确查询**：

- term：根据词条精确值查询
- range：根据值的范围查询

****

**term查询**：根据词条精确匹配，一般搜索keyword类型、数值类型、布尔类型、日期类型字段

```
GET /indexName/_search
{
  "query": {
    "term": {
      "FIELD": {
        "value": "VALUE"
      }
    }
  }
}
```

![image-20231231170353937](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312311703144.png)

****

**range查询**：根据数值范围查询，可以是数值、日期的范围

```
GET /hotel/_search
{
  "query": {
    "range": {
      "FIELD": {
        "gte": 10,
        "lte": 20
      }
    }
  }
}
```

- `gt`：大于
- `lt`：大于 
- `gte`：大于等于 
- `lte`：小于等于

![image-20231231170438178](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312311704836.png)

### 地理查询

根据经纬度查询。

**常见使用场景**：搜索附近的酒店

根据经纬度查询：

- `geo_bounding_box`：查询geo_point值落在某个矩形范围的所有文档

  ```
  GET /indexName/_search
  {
    "query": {
      "geo_bounding_box": {
        "FIELD": {
          "top_left": {
            "lat": 31.1,
            "lon": 121.5
          },
          "bottom_right": {
            "lat": 30.9,
            "lon": 121.7
          }
        }
      }
    }
  }
  ```

- `geo_distance`：查询到指定中心点小于某个距离值的所有文档

  ```
  GET /indexName/_search
  {
    "query": {
      "geo_distance": {
        "distance": "15km",
        "FIELD": "31.21,121.5"
      }
    }
  }
  ```

![image-20240101155454851](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202401011554590.png)

![image-20240101155852678](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202401011558162.png)

### 复合查询

复合(compound)查询：复合查询可以将其他简单查询组合起来，实现更复杂的搜索逻辑。

- `function score query`：算分函数查询，可以控制文档相关性算分，控制文档排名。例如百度竞价
- `boolean query`：布尔查询，由一个或多个查询子句的组合。

**相关性算分算法**：

- `TF-IDF`：在Elasticsearch5.0之前，会随着词频增加而越来越大
- `BM25`：在Elasticsearch5.0之后，会随着词频增加而增大，但增长曲线会趋于水平

![image-20240101154947855](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202404091749188.png)

![img](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202404091749760.jpeg)

#### Function Score Query

当使用match查询时，文档结果会根据与搜索词条的关联度打分(`_score`)，返回结果时按照分值降序排列。

使用 function score query，可以修改文档的相关性算分(query score)，根据新得到的算分排序。

**定义的三要素**：

- **过滤条件**：哪些文档要加分
- **算分函数**：如何计算function score
- **加权方式**：function score 与 query score 如何运算

![image-20240101163856506](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202401011638929.png)

```
GET /hotel/_search
{
  "query": {
    "function_score": {
      "query": {
        "match": {
          "all": "外滩"
        }
      },
      "functions": [
        {
          "filter": {
            "term": {
              "brand": "如家"
            }
          },
          "weight": 10
        }
      ],
      "boost_mode": "multiply"
    }
  }
}
```

![image-20240101162928092](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202401011629069.png)

#### Boolean Query

布尔查询是一个或多个查询子句的组合。

**子查询的组合方式**：

- must：必须匹配每个子查询，类似 "与"
- should：选择性匹配子查询，类似 "或"
- must_not：必须不匹配，不参与
- filter：必须匹配，不参与算分

**说明**：根据需求来选择 使用参与算分的会影响性能，一般使用关键字搜索放入must，其他的一般使用must_not或filter

```
GET /hotel/_search
{
  "query": {
    "bool": {
      "must": [
        {
          "match": {
            "name": "如家"
          }
        }
      ],
      "must_not": [
        {
          "range": {
            "price": {
              "gt": 400
            }
          }
        }
      ],
      "filter": [
        {
          "geo_distance": {
            "distance": "10km",
            "location": {
              "lat": 31.21,
              "lon": 121.5
            }
          }
        }
      ]
    }
  }
}
```

![image-20240101164856880](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202401011648139.png)

## 排序

Elasticsearch支持对搜索结果排序，默认是根据相关度算分(`_score`)来排序。可以排序的字段类型有：keyword类型、数值类型、地理坐标类型、日期类型等。

获取经纬度的方式：https://lbs.amap.com/demo/jsapi-v2/example/map/click-to-get-lnglat

**说明**：一旦使用排序后，打分机制就会失效，查询效率提高

**排序的DSL语法**：

```
GET /indexName/_search
{
  "query": {
    "match_all": {}
  },
  "sort": [
    {
      "FIELD": {
        "order": "desc" //排序字段和排序方式(ASC正序、DESC倒序)
      }
    }
  ]
}
```

```
GET /indexName/_search
{
  "query": {
    "match_all": {}
  },
  "sort": [
    {
      "_geo_distance": {
        "FIELD": {
          "lat": 40, //纬度
          "lon": -70 //经度
        },
        "order": "asc",
        "unit": "km"
      }
    }
  ]
}
```

![image-20240101151642672](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202401011516910.png)

![image-20240101152157467](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202401011521935.png)

## 分页

Elasticsearch 默认情况下只返回前十条数据。而如果要查询更多的数据就需要修改分页参数。

因为底层使用的倒排索引，其实不利于分页的，采用的是逻辑分页

Elasticsearch中通过from、size参数来控制要返回的分页结果：

```
GET /hotel/_search
{
  "query": {
    "match_all": {}
  },
  "from": 0, //分页开始的位置，默认为0
  "size": 20, //期望获取的文档总数
  "sort": [
    {
      "price": "asc"
    }
  ]
}
```

**深度分页问题**：

Elasticsearch是分布式的，所以会面临深度分页问题。

一旦做了集群就会对数据进行拆分 放到不同的机器上 拆出的每份叫分片

例如：按price排序后，获取from=990，size=10的数据：

- 首先在每个数据分片上都排序并查询前1000条文档
- 将所有节点的结果聚合，在内存中重新排序选出前1000条文档
- 最后从这1000条中，选取从990开始的10条文档

![image-20231230145318251](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202404091749138.png)

如果搜索页数过深，或者结果集 (from+size)越大，对内存和CPU的消耗也越高。因此Elasticsearch设定的结果集查询的上限是10000

**深度分页解决方案**：

针对深度分页，Elasticsearch提供了两种解决方案，[官方文档](https://www.elastic.co/guide/en/elasticsearch/reference/current/paginate-search-results.html)：

- `search after`：分页时需要排序，原理是从上一次的排序值开始，查询下一页数据。官方推荐使用的方式。
- `scroll`：原理将排序数据形成快照，保存在内存。官方已经不推荐使用。

各分页方案对比：

- `from`+`size`：
  - **优点**：支持随机翻页
  - **缺点**：深度分页问题，默认查询上限(from + size)是10000
  - **场景**：百度、京东、谷歌、淘宝这样的随机翻页搜索
- `after search`：
  - **优点**：没有查询上限 (单次查询的size不超过10000)
  - **缺点**：只能向后逐页查而不能往前查，不支持随机翻页。
  - **场景**：没有随机翻页需求的搜索，例如手机向下滚动翻页
- `scroll`：
  - **优点**：没有查询上限 (单次查询的size不超过10000)
  - **缺点**：对内存消耗较大，不推荐。而且数据更新快照，可能没有实时更新，导致查到旧数据
  - **场景**：海量数据的获取和迁移。从Elasticsearch7.1开始不推荐，建议使用`after search`方案

## 高亮显示

在搜索结果中把搜索关键字突出显示。

**原理**：

- 将搜索结果中的关键字用标签标记出来
- 在页面中给标签添加css样式

**高亮显示的DSL语法**：

```
GET /hotel/_search
{
  "query": {
    "match": {
      "FIELD": "TEXT"
    }
  },
  "highlight": {
    "fields": { //指定要高亮的字段
      "FIELD": {
        "require_field_match": "false", //默认情况下，ES搜索字段必须与高亮字段一致,为false则可以不一致
        "pre_tags": "<em>", //用来标记高亮字段的前置标签
        "post_tags": "</em>"//用来标记高亮字段的后置标签
      }
    }
  }
}
```

![image-20231231173723404](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312311737635.png)

