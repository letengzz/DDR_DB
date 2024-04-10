# Key键 操作

- **查找所有符合给定模式(pattern)的 key**：

  ```
  KEYS pattern
  ```

  - **查看当前库所有的key**：

    ```redis
    KEYS *
    ```

    ![image-20240411000808835](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404110008150.png)

  - **查找以 key 为开头的 key**：

    ```
    KEYS key*
    ```
    
    ![image-20240411000614582](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404110006200.png)

- **判断某个key是否存在**：

  ```redis
  EXISTS key
  ```

  ![image-20240410222916173](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404102229535.png)

- **删除指定的key数据**：如果键被删除成功，输出被删除 key 的数量，否则将输出0

  ```redis
  DEL key
  ```

  ![image-20240410222716010](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404102227121.png)

- **非阻塞删除**：仅仅将keys从keyspace元数据中删除

  ```redis
  unlink key
  ```

- **查看过期时间(秒)**：-1表示永不过期，-2表示已过期

  ```redis
  TTL key
  ```

  ![image-20240410223602724](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404102236337.png)

- **以毫秒为单位返回 key 的剩余的过期时间**：

  ```
  PTTL key
  ```

- **给key设置过期时间**：默认-1表示永不过期，-2表示已过期，过期后将不再可用

  设置成功返回 1 。 当 key 不存在或者不能为 key 设置过期时间时返回 0 

  Redis 的过期时间设置有四种形式：

  - **EXPIRE 秒**：设置指定的过期时间(秒)，表示的是时间间隔

    ```redis
    EXPIRE key seconds [NX|XX|GT|LT]
    ```

    ![image-20240410224947448](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404102249877.png)

  - **PEXPIRE 毫秒**：设置指定的过期时间，以毫秒为单位，表示的是时间间隔

    ```redis
    PEXPIRE key milliseconds
    ```

    ![image-20240410231459084](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404102315540.png)

  - **EXPIREAT 时间戳-秒**：设置指定的 Key 过期的 Unix 时间，单位为秒，表示的是时间/时刻

    ```redis
    EXPIREAT key timestamp
    ```

    ![image-20240410225833842](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404102258122.png)

  - **PEXPIREAT 时间戳-毫秒**：设置指定的 Key 到期的 Unix 时间，以毫秒为单位，表示的是时间/时刻

    ```redis
    PEXPIREAT key milliseconds-timestamp
    ```

    ![image-20240410235258886](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404102353222.png)

- **切换数据库**：0~15，默认为0

  ```redis
  select dbindex
  ```

- **将当前数据库的key移动到给定的数据库db中**：移动成功返回 1 ，失败则返回 0 。

  ```redis
  MOVE key dbindex (0~15)
  ```

  key 存在于当前数据库：

  ![image-20240411001320430](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404110013595.png)

  当 key 不存在的时候：

  ![image-20240411001532346](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404110015978.png)

  当源数据库和目标数据库有相同的 key 时：

  ![image-20240411001730937](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404110017948.png)

- **移除 key 的过期时间，key 将持久保持**：当 key 不存在时，返回 -2 。 当 key 存在但没有设置剩余生存时间时，返回 -1 。 否则，以毫秒为单位，返回 key 的剩余生存时间。

  ```
  PERSIST key
  ```

  ![image-20240411002320656](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404110023142.png)

- **从当前数据库中随机返回一个 key**：当数据库不为空时，返回一个 key 。 当数据库为空时，返回 nil(null)

  ```
  RANDOMKEY
  ```

  ![image-20240411002653558](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404110026221.png)

- **修改 key 的名称**：

  ```
  RENAME key newkey
  ```

  key 存在且 newkey 不存在：

  ![image-20240411003145184](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404110031355.png)

  当 key 不存在时，返回错误：

  ![image-20240411003304764](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404110033189.png)

  newkey 已存在时， RENAME 会覆盖旧 newkey：

  ![image-20240411003403751](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404110034621.png)

- **仅当 newkey 不存在时，将 key 改名为 newkey**：

  ```
  RENAMENX key newkey
  ```

  newkey 不存在，改名成功：

  ![image-20240411003559329](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404110036194.png)

  newkey存在时，失败：

  ![image-20240411003651830](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404110036934.png)

- **查看当前数据库key数量**：

  ```
  DBSIZE
  ```

  ![image-20240411002925400](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404110029455.png)

- **清空当前库**：

  ```redis
  FLUSHDB
  ```

- **删除全部库**：

  ```redis
  FLUSHALL
  ```

- **序列化给定 key 返回被序列化的值**：key 不存在返回 null (nil)，否则，返回序列化之后的值。

  ```redis
  DUMP key
  ```

  ![image-20240410222819500](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404102228808.png)
  
- **迭代数据库中的数据库键**：

  SCAN 命令是一个基于游标的迭代器，每次被调用之后， 都会向用户返回一个新的游标， 用户在下次迭代时需要使用这个新游标作为 SCAN 命令的游标参数， 以此来延续之前的迭代过程。
  
  SCAN 返回一个包含两个元素的数组， 第一个元素是用于进行下一次迭代的新游标， 而第二个元素则是一个数组， 这个数组中包含了所有被迭代的元素。如果新游标返回 0 表示迭代已结束。

  相关命令：
  
  - SSCAN 命令用于迭代集合键中的元素。
  - HSCAN 命令用于迭代哈希键中的键值对。
  - ZSCAN 命令用于迭代有序集合中的元素（包括元素成员和元素分值）。
  
  ```redis
  SCAN cursor [MATCH pattern] [COUNT count]
  ```
  
  - cursor：游标。
  - pattern：匹配的模式。
  - count：可选，用于指定每次迭代返回的 key 的数量，默认值为 10 。
  
- **key存储值的类型**：key不存在返回none

  ```
  TYPE key
  ```

  ![image-20240411003839884](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404110038705.png)