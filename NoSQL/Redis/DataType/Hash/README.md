# Hash 哈希表

Redis hash 是一个 string 类型的 field (字段) 和 value (值)  的映射表 (KV键值对，但是值也是一个键值对)，hash 特别适合用于存储对象。

Redis 中每个 hash 可以存储 2^32 - 1 键值对 (40多亿)

**常用命令**：命令不区分大小写，而key区分大小写的。

- 将哈希表 key 中的字段 field 的值设为 value ：

  ```redis
  HSET key field value
  ```

  ![image-20240503142848911](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202405031428755.png)

- 删除一个或多个哈希表字段：返回被成功删除字段的数量，不包括被忽略的字段。

  ```redis
  HDEL key field1 [field2]
  ```

  ![image-20240503143235477](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202405031432397.png)

- 查看哈希表 key 中，指定的字段是否存在：如果哈希表含有给定字段，返回 1 。 如果哈希表不含有给定字段，或 key 不存在，返回 0 。

  ```redis
  HEXISTS key field
  ```

  ![image-20240503150313097](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202405031503050.png)

- 获取存储在哈希表中指定字段的值：返回给定字段的值。如果给定的字段或 key 不存在时，返回 nil 。

  ```redis
  HGET key field 
  ```

  ![image-20240503151101342](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202405031511631.png)

- 获取在哈希表中指定 key 的所有字段和值：以列表形式返回哈希表的字段及字段值。 若 key 不存在，返回空列表。

  ```redis
  HGETALL key
  ```

  ![image-20240503151618147](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202405031516383.png)

- 为哈希表 key 中的指定字段的整数值加上增量 increment ：增量也可以为负数，相当于对指定字段进行减法操作。

  如果哈希表的 key 不存在，一个新的哈希表被创建并执行 HINCRBY 命令。

  如果指定的字段不存在，那么在执行命令前，字段的值被初始化为 0 。

  对一个储存字符串值的字段执行 HINCRBY 命令将造成一个错误。

  本操作的值被限制在 64 位(bit)有符号数字表示之内。

  ```redis
  HINCRBY key field increment
  ```

  ![image-20240503152000285](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202405031520141.png)

- 为哈希表 key 中的指定字段的浮点数值加上增量 increment ：

  ```redis
  HINCRBYFLOAT key field increment
  ```

  ![image-20240503152936257](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202405031529373.png)

- 获取哈希表中的所有字段：包含哈希表中所有域（field）列表。 当 key 不存在时，返回一个空列表。

  ```redis
  HKEYS key
  ```

  ![image-20240503153210910](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202405031532655.png)

- 获取哈希表中字段的数量：返回哈希表中字段的数量。 当 key 不存在时，返回 0 

  ```redis
  HLEN key
  ```

  ![image-20240503153356216](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202405031533330.png)

- 获取所有给定字段的值：返回一个包含多个给定字段关联值的表，表值的排列顺序和指定字段的请求顺序一样。

  ```redis
  HMGET key field1 field2
  ```

  ![image-20240503154225196](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202405031542919.png)

- 同时将多个 field-value (域-值)对设置到哈希表 key 中：此命令会覆盖哈希表中已存在的字段。如果哈希表不存在，会创建一个空哈希表，并执行 HMSET 操作。

  ```redis
  HMSET key field1 value1 field2 value2
  ```

  ![image-20240503154505710](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202405031545469.png)

- 只有在字段 field 不存在时，设置哈希表字段的值：如果哈希表不存在，一个新的哈希表被创建并进行 HSET 操作。如果字段已经存在于哈希表中，操作无效。如果 key 不存在，一个新哈希表被创建并执行 HSETNX 命令。

  ```redis
  HSETNX key field value
  ```

  ![image-20240503154805356](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202405031548846.png)

- 获取哈希表中所有值：返回一个包含哈希表中所有值的列表。 当 key 不存在时，返回一个空表

  ```redis
  HVALS key
  ```

  ![image-20240503155039808](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202405031550841.png)

- 迭代哈希表中的键值对：返回的每个元素都是一个元组，每一个元组元素由一个字段(field) 和值（value）组成。

  - cursor - 游标。
  - pattern - 匹配的模式。
  - count - 指定从数据集里返回多少元素，默认值为 10 。

  ```redis
  HSCAN key cursor [MATCH pattern] [COUNT count] 
  ```

  ![image-20240503155844313](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202405031558435.png)