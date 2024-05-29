# Elasticsearch 核心概念

Elasticsearch 是面向文档存储的，可以是数据库中的一条商品数据，一个订单信息。

## 文档

文档(document)：每条数据就是一个文档。

文档数据会被序列胡为JSON格式后存储在Elasticsearch中。

![image-20231228172414278](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312281724535.png)

## 词条

词条(term)：文档按照语义分成的词语

## 字段

JSON文档中的字段

## 索引

索引(index)：想同类型文档的集合

![image-20231228174019915](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312281740475.png)

## 映射

映射(mapping)：索引中文档的字段约束信息，类似表的结构约束

## 架构

- 数据库负责事务类型操作
- Elasticsearch负责海量数据的搜索、分析、计算

![image-20231228172726110](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312281727763.png)
