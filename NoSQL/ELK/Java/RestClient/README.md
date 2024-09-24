# RestClient 操作

## 初始化RestClient

引入Elasticsearch的RestHighLevelClient依赖：

```xml
<!-- Java RestClient-->
<dependency>
	<groupId>org.elasticsearch.client</groupId>
    <artifactId>elasticsearch-rest-high-level-client</artifactId>
    <version>7.12.1</version>
</dependency>
```

覆盖SpringBoot默认的Elasticsearch 版本：

```xml
<properties>
    <java.version>17</java.version>
	<elasticsearch.version>7.12.1</elasticsearch.version>
</properties>
```

初始化RestHighLevelClient和销毁RestHighLevelClient：

```java
package com.hjc.demo.utils;

import org.apache.http.HttpHost;
import org.elasticsearch.client.RestClient;
import org.elasticsearch.client.RestHighLevelClient;
import org.springframework.beans.factory.annotation.Value;

import java.io.IOException;

/**
 * RestHighLevelClient工具类
 *
 * @author hjc
 */
public class RestHighLevelClientUtils {


    /**
     * 初始化RestHighLevelClient方法
     * @return RestHighLevelClient
     */
    public static RestHighLevelClient initialize() {
        return new RestHighLevelClient(RestClient.builder(
                HttpHost.create("http://ip:9200")
//               使用集群 配置多个http 初始化
//                ,HttpHost.create(esUri),
//                HttpHost.create(esUri)
        ));
    }

    /**
     * 销毁RestHighLevelClient方法
     * @param client RestHighLevelClient
     * @throws IOException exp
     */
    public static void close(RestHighLevelClient client) throws IOException {
        client.close();
    }
}

```

## 操作索引库

**索引库操作基本步骤**：

- 初始化RestHighLevelClient
- 创建XxxIndexRequest。XXX是CREATE、Get、Delete
- 准备DSL (CREATE时需要)
- 发送请求。调用 RestHighLevelClient.indices().xxx()方法。xxx是create、exists、delete

### 创建索引库

定义DSL语句：

```java
/**
 * 酒店常量
 * @author hjc
 */
public class HotelConstant {
    public static final String MAPPING_TEMPLATE = 
            "{\n" +
            "  \"mappings\": {\n" +
            "    \"properties\": {\n" +
            "      \"id\": {\n" +
            "        \"type\": \"keyword\"\n" +
            "      },\n" +
            "      \"name\": {\n" +
            "        \"type\": \"text\",\n" +
            "        \"analyzer\": \"ik_max_word\"\n" +
            "      },\n" +
            "      \"address\": {\n" +
            "        \"type\": \"keyword\",\n" +
            "        \"index\": false\n" +
            "      },\n" +
            "      \"price\": {\n" +
            "        \"type\": \"integer\"\n" +
            "      },\n" +
            "      \"score\": {\n" +
            "        \"type\": \"integer\"\n" +
            "      },\n" +
            "      \"brand\": {\n" +
            "        \"type\": \"keyword\",\n" +
            "        \"copy_to\": \"all\"\n" +
            "      },\n" +
            "      \"city\": {\n" +
            "        \"type\": \"keyword\"\n" +
            "      },\n" +
            "      \"starName\":{\n" +
            "        \"type\": \"keyword\"\n" +
            "      },\n" +
            "      \"business\": {\n" +
            "        \"type\": \"keyword\"\n" +
            "      },\n" +
            "      \"location\": {\n" +
            "        \"type\": \"geo_point\"\n" +
            "      },\n" +
            "      \"pic\": {\n" +
            "        \"type\": \"keyword\",\n" +
            "        \"index\": false\n" +
            "      }\n" +
            "    }\n" +
            "  }\n" +
            "}\n";
}

```

创建索引库：

```java
package com.hjc.demo;

import com.hjc.demo.utils.RestHighLevelClientUtils;
import lombok.extern.slf4j.Slf4j;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.client.indices.CreateIndexRequest;

import org.elasticsearch.common.xcontent.XContentType;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import java.io.IOException;

import static com.hjc.demo.Constant.HotelConstant.MAPPING_TEMPLATE;

@Slf4j
@SpringBootTest
public class ElasticsearchIndexTest {

    RestHighLevelClient client = RestHighLevelClientUtils.initialize();

    /**
     * 创建索引库
     *
     * @throws IOException
     */
    @Test
    void testCreateIndex() throws IOException {
        //1.创建Request对象
        CreateIndexRequest request = new CreateIndexRequest("hotel");
        //2.请求参数，MAPPING_TEMPLATE是静态常量字符串，内容是创建索引库的DSL语句
        request.source(MAPPING_TEMPLATE, XContentType.JSON);
        //3.发起请求
        client.indices().create(request, RequestOptions.DEFAULT);
    }

    @AfterEach
    void tearDown() throws IOException {
        //销毁RestHighLevelClient
        RestHighLevelClientUtils.close(client);
    }
}
```

![image-20231229002823352](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312290028907.png)

执行，查看是否创建成功：

![image-20231229003258934](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312290033733.png)

### 删除索引库

删除索引库：

```java
package com.hjc.demo;

import com.hjc.demo.utils.RestHighLevelClientUtils;
import lombok.extern.slf4j.Slf4j;
import org.elasticsearch.action.admin.indices.delete.DeleteIndexRequest;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.client.indices.CreateIndexRequest;

import org.elasticsearch.client.indices.GetIndexRequest;
import org.elasticsearch.common.xcontent.XContentType;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import java.io.IOException;

import static com.hjc.demo.Constant.HotelConstant.MAPPING_TEMPLATE;

@Slf4j
@SpringBootTest
public class ElasticsearchIndexTest {

    RestHighLevelClient client = RestHighLevelClientUtils.initialize();

    /**
     * 删除索引库
     * @throws IOException
     */
    @Test
    void testDeleteIndex() throws IOException {
        //1.创建Request对象
        DeleteIndexRequest request = new DeleteIndexRequest("hotel");
        //2.发起请求
        client.indices().delete(request, RequestOptions.DEFAULT);

    }

    @AfterEach
    void tearDown() throws IOException {
        //销毁RestHighLevelClient
        RestHighLevelClientUtils.close(client);
    }
}
```

执行，查看是否删除成功：

![image-20231229004338893](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312290043322.png)

### 判断索引库存在

判断索引库存在：

```java
package com.hjc.demo;

import com.hjc.demo.utils.RestHighLevelClientUtils;
import lombok.extern.slf4j.Slf4j;
import org.elasticsearch.action.admin.indices.delete.DeleteIndexRequest;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.client.indices.CreateIndexRequest;

import org.elasticsearch.client.indices.GetIndexRequest;
import org.elasticsearch.common.xcontent.XContentType;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import java.io.IOException;

import static com.hjc.demo.Constant.HotelConstant.MAPPING_TEMPLATE;

@Slf4j
@SpringBootTest
public class ElasticsearchIndexTest {

    RestHighLevelClient client = RestHighLevelClientUtils.initialize();
    
    /**                    
 	* 判断索引库是否存在           
 	* @throws IOException 
 	*/                     
    @Test
    void testExistIndex() throws IOException {
        //1.创建Request对象
        GetIndexRequest request = new GetIndexRequest("hotel");
        //2.发起请求
        boolean exists = client.indices().exists(request, RequestOptions.DEFAULT);
        //3.输出结果
        log.error(exists?"索引库存在":"索引库不存在");
    }

    @AfterEach
    void tearDown() throws IOException {
        //销毁RestHighLevelClient
        RestHighLevelClientUtils.close(client);
    }
}
```

执行，查看是否存在：

![image-20231229004425771](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312290044700.png)

## 操作文档

**文档操作基本步骤**：

- 初始化RestHighLevelClient
- 创建XxxRequest。XXX是Index、Get、Update、Delete
- 准备参数 (Index和Update时需要)
- 发送请求。调用 RestHighLevelClient.xxx()方法。xxx是index、get、update、delete
- 解析结果 (Get时需要)

### 新建文档

新建文档：

```java
@Test
void testIndexDocument() throws IOException {
    //1.创建request对象
    IndexRequest request = new IndexRequest("indexName").id("1");
    //2.准备JSON文档
    request.source("{\"name\": \"你好中国\",\"age\": 21}", XContentType.JSON);
    //3.发送请求
	client.index(request, RequestOptions.DEFAULT);
}
```

![image-20231229140132662](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312291401486.png)

### 查询文档

根据id查询到的文档数据是JSON，需要反序列化为Java对象：

```java
@Test
void testSelectIndexDocument() throws IOException {
    //1.创建request对象
    GetRequest request = new GetRequest("indexName", "1");
    //2.发送请求,得到结果
    GetResponse response = client.get(request, RequestOptions.DEFAULT);
    //3.解析响应
    String json = response.getSourceAsString();
	log.info("查询结果:{}", json);
}
```

![image-20231229135558281](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312291355703.png)

### 修改文档

修改文档数据方式：

- 全量更新。再次写入id一样的文档，就会删除旧文档，添加新文档。代码同[新增](#新增文档)

- 局部更新。只更新部分字段

  ```java
  @Test
  void testUpdateDocumentById() throws IOException {
  	//1.创建request对象
      UpdateRequest request = new UpdateRequest("indexname", "1");
      //2.准备json数据 每两个参数为一对key value
      request.doc(
              "age",18,
              "name", "张三"
      );
      //3.更新文档
      client.update(request, RequestOptions.DEFAULT);
  }
  ```

  ![image-20231229141208751](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202312291412169.png)

### 删除文档

删除文档：

```java
@Test
void testDeleteDocument() throws IOException {
    //1.准备Request
    DeleteRequest request = new DeleteRequest("indexname", "1");
    //2.发送请求
	client.delete(request,RequestOptions.DEFAULT);
}
```

### 批量导入文档

使用JavaRestClient中的Bulk批处理，实现批量新增文档：

```java
@Test
void testBulk() throws IOException {
    //1.创建Bulk请求
    BulkRequest request = new BulkRequest();
    //2.添加要批量提交的请求: 添加了两个新增文档的请求
    request.add(new IndexRequest("hotel")
            .id("101").source("json source",XContentType.JSON));
    request.add(new IndexRequest("hotel")
            .id("101").source("json source2",XContentType.JSON));
    //3.发起bulk请求
	client.bulk(request,RequestOptions.DEFAULT);
}
```

