## 生产集群部署

要将Elasticsearch部署到生产环境中，需要考虑机器的内存、CPU、磁盘、JVM等各种资源和配置。

### 内存

在Elasticsearch生产环境中，最容易耗尽的资源就是内存。排序和聚合都会耗费掉很多内存，所以给Elasticsearch进程分配足够的JVM heap是很重要的。除了给JVM heap分配内存，还需要给予足够的内存给 `cs filesystem cache`，因为lucene使用的数据结构都是给予磁盘的格式，elasticsearch是通过`cs cache` 来进行高性能的磁盘文件读写的。

如果一个机器有64G内存，是比较理想的状态。但是32G和16G也是OK的。**具体的内存数据还是根据数据量来决定的**。但是如果一个机器的内存小于8G，那么就不太适合生产环境，因为需要部署很多小内存的机器来搭建集群，运维成本和效率会很低。而大于64G的机器也不是很有必要。

### CPU

大多数的elasticsearch集群对于CPU的要求都会比较低一些，因此一台机器有多少啊个CPU core其实对生产环境的elasticsearch集群部署相对来说没有那么的重要，至少没有内存来的重要啊，**一般来说2个CPU core~8个CPU core都可以**。

### 磁盘

对于elasticsearch的生产环境来说，磁盘是非常重要的，尤其是对那些大量写入的elasticsearch集群。比如互联网公司将每天的实时日志数据以高并发的速度写入到elasticsearch集群中。在服务器上，磁盘是最慢的资源，所以对于大量写入的elasticsearch集群来说，会很容易因为磁盘的读写性能造成整个集群的性能瓶颈。

如果使用的SSD硬盘，那么就需要检查I/O scheduler，需要正确的配置IO scheduler。当将数据写入磁盘时，IO scheduler会决定什么时候数据才会真正的写入磁盘，而不是停留在os cache内存缓冲中。大多数机器上，默认的IO scheduler是cfq(completely fair queuing)。这个scheduler会给每个进程都分配一些时间分片。

### 优化建议

![image-20240104140631760](assets/image-20240104140631760.png)

![image-20240104141134956](assets/image-20240104141134956.png)

规划硬件配置、

![image-20240104141416207](assets/image-20240104141416207.png)

需要大于8G

![image-20240104141733663](assets/image-20240104141733663.png)

内存小于8g 需要大量小内存搭建集群

大于64g不是很有必要

内存耗费主要是 jvm的堆、主要还是机器剩余的内存缓存索引文件数据

具体看数据量

![image-20240104144012689](assets/image-20240104144012689.png)

![image-20240104144214764](assets/image-20240104144214764-17043505351141.png)

需要专业运维 做好

![image-20240104145021947](assets/image-20240104145021947.png)

尽量不要把一个集群放在多个机房

![image-20240104145648110](assets/image-20240104145648110-17043514083973.png)

![image-20240104145835755](assets/image-20240104145835755.png)

![image-20240104150451857](assets/image-20240104150451857.png)

![image-20240104150617023](assets/image-20240104150617023.png)

![image-20240104150733220](assets/image-20240104150733220.png)

## 搭建

![image-20240104150831395](assets/image-20240104150831395.png)

![image-20240104151031174](assets/image-20240104151031174.png)

![image-20240104151148966](assets/image-20240104151148966.png)

![image-20240104151156492](assets/image-20240104151156492.png)

![image-20240104151411920](assets/image-20240104151411920.png)

![image-20240104151438165](assets/image-20240104151438165.png)

![image-20240104151443104](assets/image-20240104151443104.png)

![image-20240104151452199](assets/image-20240104151452199.png)

![image-20240104151458633](assets/image-20240104151458633.png)

![image-20240104151503139](assets/image-20240104151503139.png)

![image-20240104151540897](assets/image-20240104151540897.png)

![image-20240104151554011](assets/image-20240104151554011.png)

![image-20240104151614538](assets/image-20240104151614538.png)

![image-20240104151635948](assets/image-20240104151635948-17043525963105.png)

![image-20240104151710593](assets/image-20240104151710593.png)

![image-20240104151728669](assets/image-20240104151728669.png)

![image-20240104151753608](assets/image-20240104151753608.png)

![image-20240104151830086](assets/image-20240104151830086.png)

![image-20240104151924176](assets/image-20240104151924176.png)

![image-20240104152014206](assets/image-20240104152014206.png)

![image-20240104152027883](assets/image-20240104152027883.png)

![image-20240104152130728](assets/image-20240104152130728.png)

![image-20240104152351486](assets/image-20240104152351486.png)

![image-20240104152422540](assets/image-20240104152422540.png)

![image-20240104152427998](assets/image-20240104152427998.png)

![image-20240104152453484](assets/image-20240104152453484.png)

![image-20240104152508175](assets/image-20240104152508175.png)

![image-20240104152515900](assets/image-20240104152515900.png)

![image-20240104152541724](assets/image-20240104152541724.png)

![image-20240104152600632](assets/image-20240104152600632.png)

![image-20240104152607090](assets/image-20240104152607090.png)

![image-20240104152624129](assets/image-20240104152624129.png)

![image-20240104152638113](assets/image-20240104152638113.png)

![image-20240104152646151](assets/image-20240104152646151.png)

![image-20240104152651362](assets/image-20240104152651362.png)

![image-20240104152716855](assets/image-20240104152716855.png)

![image-20240104153246541](assets/image-20240104153246541.png)



![image-20240104153343319](assets/image-20240104153343319.png)



![image-20240104153759935](assets/image-20240104153759935.png)

![image-20240104153812984](assets/image-20240104153812984.png)



![image-20240104153837560](assets/image-20240104153837560.png)

![image-20240104153847222](assets/image-20240104153847222.png)

![image-20240104153855285](assets/image-20240104153855285.png)

![image-20240104153903165](assets/image-20240104153903165.png)

![image-20240105092918417](assets/image-20240105092918417.png)

![image-20240105093155579](assets/image-20240105093155579.png)

![image-20240105093214875](assets/image-20240105093214875.png)

![image-20240105093250109](assets/image-20240105093250109.png)

![image-20240105093332253](assets/image-20240105093332253.png)

![image-20240105093358965](assets/image-20240105093358965.png)

![image-20240105093516805](assets/image-20240105093516805.png)

![image-20240105093529028](assets/image-20240105093529028.png)

![image-20240105093542802](assets/image-20240105093542802.png)

![image-20240105093617122](assets/image-20240105093617122.png)

![image-20240105093714381](assets/image-20240105093714381.png)

![image-20240105093729104](assets/image-20240105093729104.png)

![image-20240105093920129](assets/image-20240105093920129.png)

![image-20240105094058429](assets/image-20240105094058429.png)

![image-20240105094122013](assets/image-20240105094122013.png)

![image-20240105094133836](assets/image-20240105094133836.png)

![image-20240105094233736](assets/image-20240105094233736.png)

![image-20240105094247681](assets/image-20240105094247681.png)

![image-20240105094517063](assets/image-20240105094517063.png)

空闲只有2g

