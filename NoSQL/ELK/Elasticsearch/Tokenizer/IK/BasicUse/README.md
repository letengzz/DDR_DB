# IK 分词器

Elasticsearch 在创建倒排索引时需要对文档进行分词，在搜索时，需要对用户输入的内容进行分词。但是默认的分词规则对中文的处理并不友好，会将每个中文字符当做一个词。处理中文分词，一般会使用IK分词器。

**官方网站**：https://github.com/medcl/elasticsearch-analysis-ik

 在Kibana的DevTools中测试默认分词器：

```
#基础分词器
GET /_analyze
{
  "analyzer": "standard",
  "text": "使用elasticsearch测试"
}
```

效果：

![image-20231228191423681](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312281914165.png)

## 分词的作用

- 将文档创建倒排索引的时候，要对某个文档进行分词，把词条创建倒排索引

- 当用户搜索的时候，对输入的内容进行分词

## 安装IK插件

### 在线安装ik插件

```
# 进入容器内部
docker exec -it es /bin/bash

# 在线下载并安装
./bin/elasticsearch-plugin  install https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v7.12.1/elasticsearch-analysis-ik-7.12.1.zip

#退出
exit
```

### 离线安装ik插件

#### 查看数据卷目录

安装插件需要知道elasticsearch的plugins目录位置，而我们用了数据卷挂载，因此需要查看elasticsearch的数据卷目录，通过下面命令查看：

```
docker volume inspect es-plugins
```

![image-20231228194409739](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312281944552.png)

说明plugins目录被挂载到了：`/var/lib/docker/volumes/es-plugins/_data `这个目录中。

#### 解压缩分词器安装包

通过：https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v7.12.1/elasticsearch-analysis-ik-7.12.1.zip 下载并解压，重命名为ik

![image-20210506110249144](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312281946068.png)

#### 上传到es容器的插件数据卷中

![image-20210506110704293](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312281946544.png)

###  重启容器

```shell
# 重启容器
docker restart es
```

```sh
# 查看es日志
docker logs -f es
```

## IK 分词模式

IK分词器包含两种模式：

* `ik_smart`：最少切分。分词少查询的结果少，占用的内存空间少，内存能够缓存更多的数据，提高查询效率

* `ik_max_word`：最细切分。占用空间更多，切分越细 ，被搜索的概率越高，但是会带来更大的内存消耗

**需要根据具体情况来衡量使用哪个模式**。

## IK 基本使用

```
#ik分词器 最细粒度分词器 
GET /_analyze
{
  "analyzer": "ik_max_word",
  "text": "程序员学习Elasticsearch太爽了"
}
```

![image-20231228200532843](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202404091730992.png)

```
#ik分词器 粗粒度分词
GET /_analyze
{
  "analyzer": "ik_smart",
  "text": "程序员学习Elasticsearch太爽了"
}
```

![image-20231228200647666](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312282006367.png)

## 拓展词库

IK分词器使用的基础字典没有某些词 会被分成两个字，此时需要拓展IK分词器的词库，使用个性化设置来解决

**操作步骤**：

1. 进入`/var/lib/docker/volumes/es-plugins/_data/ik/config/`，打开IKAnalyzer.cfg.xml，将key为ext_dict标签中添加 ext.dic

   ![image-20231228201208510](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312282012067.png)

2. 在`/var/lib/docker/volumes/es-plugins/_data/ik/config/`下添加：ext.dic

   ![image-20231228201258813](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312282013132.png)

3. 在名为 ext.dic 文件中，添加要拓展的词语，保存即可：

   **注意**：当前文件的编码必须是 UTF-8 格式，严禁使用Windows记事本编辑

   ![image-20231228201455497](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312282014171.png)

4. 重新启动，让其生效：

   ```
   docker restart es
   ```

5. 测试：

   ![image-20231228201716130](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312282017375.png)

## 停用词库

某些关键字比如"的"可以考虑不分词，减少内存占用，某些敏感关键字也需要屏蔽

**操作步骤**：

1. 在`/var/lib/docker/volumes/es-plugins/_data/ik/config/`下找到ext_stopwords：

   ![image-20231228201921322](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202404091731468.png)

2. 在名为 stopword.dic 文件中，添加要停用的词语，保存即可：

   **注意**：当前文件的编码必须是 UTF-8 格式，严禁使用Windows记事本编辑

   ![image-20231228202230874](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312282022071.png)

3. 重新启动，让其生效：

   ```
   docker restart es
   ```

4. 测试：

   ![image-20231228202554216](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312282025315.png)

## 基于MySQL实现热更新

**说明**：如果版本是8.x，需要jdk8以上。

添加数据库并添加两个字段，两个表结构相同：

![image-20240108223504258](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202401082235030.png)

下载对应版本的源码：https://github.com/medcl/elasticsearch-analysis-ik/releases

![image-20240108221635946](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202401082216701.png)

打开项目源码，在config中添加`jdbc-reload.properties`：

> jdbc-reload.properties

```properties
jdbc.url=jdbc:mysql://localhost:3306/es?serverTimezone=UTC&characterEncoding=utf8
jdbc.username=root
jdbc.password=123123
jdbc.reload.sql=select word from ext_words
jdbc.reload.stopword.sql=select word from stop_words
jdbc.reload.interval=10000 // 毫秒 请注意调整
```

打开 `org.wltea.analyzer.dic.Dictionary`：

![image-20240108222445840](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202404091731105.png)

找到loadMainDict方法，并添加 `this.loadMySQLExtDict()`：

```
private void loadMainDict() {
	// 建立一个主词典实例
	_MainDict = new DictSegment((char) 0);

	// 读取主词典文件
	Path file = PathUtils.get(getDictRoot(), Dictionary.PATH_DIC_MAIN);
	loadDictFile(_MainDict, file, false, "Main Dict");
	// 加载扩展词典
	this.loadExtDict();
	// 加载远程自定义词库
	this.loadRemoteExtDict();
	// 加载MySQL词库
	this.loadMySQLExtDict();
}
```

![image-20240108223015626](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202404091731805.png)

添加 `loadMySQLExtDict()`方法：

```java
private static Properties prop = new Properties();
static {
	try {
    	Class.forName("com.mysql.cj.jdbc.Driver");
    } catch (ClassNotFoundException e) {
        throw new RuntimeException(e);
    }
}
/**
 * 加载基于 MySQL的远程词库
 */
private void loadMySQLExtDict() {
    Connection conn = null;
    Statement stat = null;
    ResultSet rs = null;
    try {
        Path file = PathUtils.get(getDictRoot(), "jdbc-reload.properties");
        prop.load(new FileInputStream(file.toFile()));
        conn = DriverManager.getConnection(
                prop.getProperty("mysql.url"),
                prop.getProperty("mysql.username"),
                prop.getProperty("mysql.password")
        );
        stat = conn.createStatement();
        rs = stat.executeQuery(prop.getProperty("jdbc.reload.sql"));
        while (rs.next()) {
            String word = rs.getString("word");
            _MainDict.fillSegment(word.trim().toLowerCase().toCharArray());
        }
        Thread.sleep(Integer.valueOf(String.valueOf(prop.get("jdbc.reload.interval"))));
    } catch (IOException | SQLException | InterruptedException e) {
        logger.error("加载远程词库失败", e);
    } finally {
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
        if (stat != null) {
            try {
                stat.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
    }
}
```

添加HotDic：

```java
public class HotDic implements Runnable{
    @Override
    public void run() {
        while (true){
            // 远程词库有更新,需要重新加载词典，并修改last_modified,eTags
            Dictionary.getSingleton().reLoadMainDict();
        }
    }
}
```

修改initial()方法：

```java
public static synchronized void initial(Configuration cfg) {
    if (singleton == null) {
        synchronized (Dictionary.class) {
            if (singleton == null) {

                singleton = new Dictionary(cfg);
                singleton.loadMainDict();
                singleton.loadSurnameDict();
                singleton.loadQuantifierDict();
                singleton.loadSuffixDict();
                singleton.loadPrepDict();
                singleton.loadStopWordDict();
                new Thread(new HotDic()).start();
                if (cfg.isEnableRemoteDict()) {
                    // 建立监控线程
                    for (String location : singleton.getRemoteExtDictionarys()) {
                        // 10 秒是初始延迟可以修改的 60是间隔时间 单位秒
                        pool.scheduleAtFixedRate(new Monitor(location), 10, 60, TimeUnit.SECONDS);
                    }
                    for (String location : singleton.getRemoteExtStopWordDictionarys()) {
                        pool.scheduleAtFixedRate(new Monitor(location), 10, 60, TimeUnit.SECONDS);
                    }
                }
            }
        }
    }
}
```

修改版本：

![image-20240108233732277](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202401082337532.png)

使用Maven打包，并将此文件放入到Elasticsearch：

![image-20240108233852422](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202401082338540.png)

解压并改名为ik：

![image-20240108234017173](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202401082340891.png)

添加驱动：

![image-20240108234703510](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202401082347322.png)

重启Elasticsearch：

```
docker restart es
```
