# List 列表

Redis列表是简单的字符串列表 (单key多value)，按照插入顺序排序。**可以添加一个元素到列表的头部 (左边) 或者尾部 (右边)**

**底层原理**：底层实际是个**双向链表**，，最多可以包含 2^32 - 1 个元素 (4294967295, 每个列表超过40亿个元素)。**对两端的操作性能很高，通过索引下标的操作中间的节点性能会较差**

![](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404212135730.png)

**说明**：

- left、right都可以插入添加
- 如果键不存在，创建新的链表
- 如果键已存在，新增内容
- 如果值全移除，对应的键也就消失了

**应用场景**：

- 微信公众号订阅消息：
  1. 公众号作者发布了文章分别是 11 和 22
  2. 关注作者，只要他们发布了新文章，就会装进我的List
  3. 查看自己的号订阅的全部文章，类似分页，下面0~10就是一次显示10条

**常用命令**：命令不区分大小写，而key区分大小写的。

- **将一个或多个值插入到列表头部**：第一个元素为后添加的值

  ```redis
  LPUSH key value1 [value2 ...]
  ```

  ![image-20240422220553430](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404222205134.png)

- **将一个或多个值插入到列表尾部**：第一个元素为先添加的值

  ```
  RPUSH key value1 [value2 ...]
  ```

  ![image-20240422220830473](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404222208814.png)

- **将一个值插入到已存在的列表头部**：

  ```redis
  LPUSHX key value
  ```

  ![image-20240422221330868](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404222213464.png)

- **将一个值插入到已存在的列表尾部**：

  ```
  RPUSHX key value
  ```

  ![image-20240422221532423](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404222215522.png)

- **在列表的元素前或者后插入元素**：

  ```redis
  LINSERT key BEFORE|AFTER pivot value 
  ```

  ![image-20240422222100231](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404222221569.png)

  ![image-20240422222205388](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404222222631.png)

- **通过索引设置列表元素的值**：

  ```redis
  LSET key index value 
  ```

  ![image-20240422222646259](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404222226502.png)

- 通过索引获取列表中的元素

  ```redis
  LINDEX key index
  ```

  ![image-20240422222913360](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404222229667.png)

- **获取列表长度**：

  ```
  LLEN key
  ```

  ![image-20240422223033118](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404222230245.png)

- 获取列表指定范围内的元素

  ```redis
  LRANGE key start stop 
  ```

  ![image-20240422223857505](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404222238922.png)

- **移出并获取列表的第一个元素**：

  ```redis
  LPOP key
  ```

  ![image-20240422223950447](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404222239519.png)

- **移除列表的最后一个元素**：返回值为移除的元素

  ```redis
  RPOP key
  ```

  ![image-20240422224035636](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404222240819.png)

- **移除列表最后一个元素并将该值添加到另一个列表并返回**：当添加到不存在表则会新建出该表

  ```redis
  RPOPLPUSH source destination
  ```

  ![image-20240422224351626](./assets/image-20240422224351626.png)

- **对列表进行修剪(trim)**：让列表只保留指定区间内的元素，不在指定区间之内的元素都将被删除

  ```redis
  LTRIM key start stop
  ```

  ![image-20240422224540733](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404222245737.png)

- **移除列表元素**：返回被移除元素的数量。 列表不存在时返回 0

  根据参数 COUNT 的值，移除列表中与参数 VALUE 相等的元素。

  COUNT 的值：

  - count > 0：从表头开始向表尾搜索，移除与 VALUE 相等的元素，数量为 COUNT 。
  - count < 0：从表尾开始向表头搜索，移除与 VALUE 相等的元素，数量为 COUNT 的绝对值。
  - count = 0：移除表中所有与 VALUE 相等的值。

  ```redis
  LREM key count value
  ```

  ![image-20240422225111247](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404222251651.png)

- **移出并获取列表的第一个元素**：如果列表没有元素会阻塞列表直到等待超时或发现可弹出元素为止。如果列表为空，返回一个 nil 。 否则，返回一个含有两个元素的列表，第一个元素是被弹出元素所属的 key ，第二个元素是被弹出元素的值。

  ```
  BLPOP key1 key2 timeout 
  ```

  操作会被阻塞，如果指定的列表 key list 存在数据则会返回第一个元素，否则在等待100秒后会返回 nil ：

  ![image-20240422225426024](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404222254029.png)

- **移出并获取列表的最后一个元素**：如果列表没有元素会阻塞列表直到等待超时或发现可弹出元素为止。如果列表没有元素会阻塞列表直到等待超时或发现可弹出元素为止。如果列表为空，返回一个 nil 。 否则，返回一个含有两个元素的列表，第一个元素是被弹出元素所属的 key ，第二个元素是被弹出元素的值。

  ```redis
  BRPOP key1 key2 timeout 
  ```

  ![image-20240422225944859](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404222259855.png)

- **从列表中弹出一个值，将弹出的元素插入到另外一个列表中并返回它**：如果列表没有元素会阻塞列表直到等待超时或发现可弹出元素为止。假如在指定时间内没有任何元素被弹出，则返回一个 nil 和等待时长。 反之，返回一个含有两个元素的列表，第一个元素是被弹出元素的值，第二个元素是等待时长。

  ```
  BRPOPLPUSH source destination timeout 
  ```

  ![image-20240422230341186](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404222303206.png)
