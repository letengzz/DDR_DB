# Windows 安装 Elasticsearch

1. 安装JDK，至少1.8.0_73以上版本，验证：java -version

   ```shell
   java -version
   ```

   ![image-20231228091539411](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312280915876.png)

2. 下载和解压缩Elasticsearch安装包：https://www.elastic.co/cn/downloads/elasticsearch

   ![image-20231228091809628](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312280918676.png)

3. 查看目录结构：                  

   - bin：脚本目录，包括：启动、停止等可执行脚本


   - config：配置文件目录


   - data：索引目录，存放索引文件的地方


   - logs：日志目录


   - modules：模块目录，包括了es的功能模块


   - plugins :插件目录，es支持插件机制
