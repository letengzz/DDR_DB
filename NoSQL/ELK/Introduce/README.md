# Elastic Stack 概述

ELK是一个免费开源的日志分析架构技术栈总称。包含三大基础组件，分别是Elasticsearch、Logstash、Kibana。但实际上ELK不仅仅适用于日志分析，它还可以支持其它任何数据搜索、分析和收集的场景，日志分析和收集只是更具有代表性。并非唯一性。

**官方网站**：https://www.elastic.co/cn

**ELK架构**：

![01-elk stack简介](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312280055635.jpg)

随着elk的发展，又有新成员Beats、elastic cloud的加入，所以就形成了Elastic Stack。所以说，ELK是旧的称呼，Elastic Stack是新的名字。

![1567691098941](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312272317042.png)

## 特色

- **处理方式灵活**：elasticsearch是目前最流行的准实时全文检索引擎，具有高速检索大数据的能力。

- 配置简单：安装elk的每个组件，仅需配置每个组件的一个配置文件即可。修改处不多，因为大量参数已经默认配在系统中，修改想要修改的选项即可。

- **接口简单**：采用json形式RESTFUL API接受数据并响应，无关语言。

- **性能高效**：elasticsearch基于优秀的全文搜索技术Lucene，采用倒排索引，可以轻易地在百亿级别数据量下，搜索出想要的内容，并且是秒级响应。

- **灵活扩展**：elasticsearch和logstash都可以根据集群规模线性拓展，elasticsearch内部自动实现集群协作。

- **数据展现华丽**：kibana作为前端展现工具，图表华丽，配置简单。

##  组件介绍

### Elasticsearch

Elasticsearch 是使用java开发，基于Lucene、分布式、通过Restful方式进行交互的近实时搜索平台框架，是整个ELK中的核心。

**特点**：分布式，零配置，自动发现，索引自动分片，索引副本机制，restful风格接口，多数据源，自动搜索负载等。

### Logstash

Logstash 基于java开发，是一个数据抽取转化工具。一般工作方式为C/S架构，Client端安装在需要收集信息的主机上，Server端负责将收到的各节点日志进行过滤、修改等操作在一并发往elasticsearch或其他组件上去。 

### Kibana

Kibana 基于nodejs，也是一个开源和免费的可视化工具。Kibana可以为 Logstash 和 ElasticSearch 提供的日志分析友好的 Web 界面，可以汇总、分析和搜索重要数据日志。

### Beats

Beats 平台集合了多种单一用途数据采集器。它们从成百上千或成千上万台机器和系统向 Logstash 或 Elasticsearch 发送数据。

**Beats组成**：

- Packetbeat：轻量型网络数据采集器。用于深挖网线上传输的数据，了解应用程序动态。Packetbeat 是一款轻量型网络数据包分析器，能够将数据发送至 Logstash 或 Elasticsearch。其支 持ICMP (v4 and v6)、DNS、HTTP、Mysql、PostgreSQL、Redis、MongoDB、Memcache等协议。


- Filebeat：轻量型日志采集器。当要面对成百上千、甚至成千上万的服务器、虚拟机和容器生成的日志时，请告别 SSH 吧。Filebeat 将为您提供一种轻量型方法，用于转发和汇总日志与文件，让简单的事情不再繁杂。


- Metricbeat ：轻量型指标采集器。Metricbeat 能够以一种轻量型的方式，输送各种系统和服务统计数据，从 CPU 到内存，从 Redis 到 Nginx，不一而足。可定期获取外部系统的监控指标信息，其可以监控、收集 Apache http、HAProxy、MongoDB、MySQL、Nginx、PostgreSQL、Redis、System、Zookeeper等服务。


- Winlogbeat：轻量型 Windows 事件日志采集器。用于密切监控基于 Windows 的基础设施上发生的事件。Winlogbeat 能够以一种轻量型的方式，将 Windows 事件日志实时地流式传输至 Elasticsearch 和 Logstash。


- Auditbeat：轻量型审计日志采集器。收集您 Linux 审计框架的数据，监控文件完整性。Auditbeat 实时采集这些事件，然后发送到 Elastic Stack 其他部分做进一步分析。


- Heartbeat：面向运行状态监测的轻量型采集器。通过主动探测来监测服务的可用性。通过给定 URL 列表，Heartbeat 仅仅询问：网站运行正常吗？Heartbeat 会将此信息和响应时间发送至 Elastic 的其他部分，以进行进一步分析。


- Functionbeat：面向云端数据的无服务器采集器。在作为一项功能部署在云服务提供商的功能即服务 (FaaS) 平台上后，Functionbeat 即能收集、传送并监测来自您的云服务的相关数据。


### Elastic cloud

基于 Elasticsearch 的软件即服务(SaaS)解决方案。通过 Elastic 的官方合作伙伴使用托管的 Elasticsearch 服务。

**官方网站**：https://www.elastic.co/cn/cloud

![image-20231227232154323](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312272321312.png)
