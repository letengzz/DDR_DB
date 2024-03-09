# Redis 概述

Redis(远程字典服务器，**RE**mote **Di**ctionary **S**erver) 是一个开源的高性能键值对数据库。使用ANSIC语言编写遵守BSD协议，是一个高性能的Key-Value数据库提供了丰富的数据结构，例如String、Hash、List、Set、SortedSet等适应不同场最下的存储需求，并借助许多高层级的接口使其可以胜任如缓存、队列系统等不同的角色。数据是存在内存中的，同时Redis支持事务、持久化、LUA脚本、发布/订阅、缓存淘汰、流技术等多种功能特性提供了主从模式、Redis Sentinel和Redis Cluster集群架构方案。

Redis之父安特雷兹：

- Github：https://github.com/antirez
- 个人博客：http://antirez.com/latest/0

**特性**：

- K-V存储结构
- 内存存储与持久化
- 功能丰富
- 简单稳定

![](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img%E4%B8%8B%E8%BD%BD%20.png)

## 两大维度/三大主线

"**两大维度**"：

- 系统维度
- 应用维度

"**三大主线**"：简称为"三高"

- 高性能：线程模型、数据结构、持久化、网络框架
- 高可靠：主从复制、哨兵机制
- 高可扩展：数据分片、负载均衡

![](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img%E4%B8%8B%E8%BD%BD.jpeg)

## 应用场景

![](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img%E4%B8%8B%E8%BD%BD-9914224.png)

- **分布式缓存**：与传统数据库关系(mysql)，Redis是key-value数据库(NoSQL一种)，mysql是关系数据库

  Redis数据操作主要在内存，而mysql主要存储在磁盘

  Redis在某一些场景使用中要明显优于mysql，比如计数器、排行榜等方面

  Redis通常用于一些特定场景，需要与Mysql一起配合使用

  两者并不是相互替换和竞争关系，而是共用和配合使用

  ![](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img%E4%B8%8B%E8%BD%BD.png)

- **内存存储和持久化**：内存存储和持久化(RDB+AOF) ，Redis支持异步将内存中的数据写到硬盘上，同时不影响继续服务

- **高可用架构搭配**：单机、主从、哨兵、集群。

- **分布式锁**

- **队列**：Reids提供list和set操作，这使得Redis能作为一个很好的消息队列平台来使用。通过Reids的队列功能做购买限制。比如到节假日或者推广期间，进行一些活动，

  对用户购买行为进行限制，限制今天只能购买几次商品或者一段时间内只能购买一次。也比较适合适用。

- **排行榜+点赞**：在互联网应用中，有各种各样的排行榜，如电商网站的月度销量排行榜、社交APP的礼物排行榜、小程序的投票排行榜等等。Redis提供的zset数据类型能够快速实现这些复杂的排行榜。

  比如小说网站对小说进行排名，根据排名，将排名靠前的小说推荐给用户

## 优势

- **性能极高**：Redis能读的速度是110000次/秒，写的速度是81000次/秒
- **数据类型丰富**：不仅仅支持简单的key-value类型的数据，同时提供list、set、zset、hash等数据结构的存储
- **持久化**：可以将内存中的数据保存在磁盘中，重启的时候可以再次加载进行使用
- **数据备份**：master-slave模式的数据备份