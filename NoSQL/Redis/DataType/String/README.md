# String 字符串

String是redis最基本的类型，**一个key对应一个value**。

String类型是**二进制安全**的，意思是redis的string可以包含任何数据，比如jpg图片或者序列化的对象 。

String类型是Redis最基本的数据类型，一个redis中字符串value最多可以是512M

**官网地址**：https://redis.io/docs/data-types/strings/

**应用场景**：

1. 点击某个视频或商品，点一次加一次
2. 阅读数：只要点击了rest地址，直接可以使用`incr key` 命令增加一个数字1，完成记录数字。

**常用命令**：命令不区分大小写，而key区分大小写的。

- **帮助**：

  ```redis
  help @string
  ```

  ![image-20240420161128255](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404201611271.png)

- **设置指定key的值**：

  ![](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404211930574.png)

  ```
  SET key value [NX|XX] [GET] [EX seconds|PX milliseconds|EXAT unix-time-seconds|PXAT unix-time-milliseconds|KEEPTTL]
  ```

  ```
  SET k1 v1 ex 30
  TTL k1
  ```

  ![image-20240421194155910](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404211942145.png)

  ![image-20240421194256096](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404211942398.png)

  ![image-20240421195453090](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404211954932.png)

- **当key不存在时设置key的值**：

  ```redis
  SETNX key value
  ```

  ![image-20240421195840124](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404211958039.png)

- **设置带过期时间的值 (秒为单位)**：

  ```
  SETEX key seconds value
  ```

  ![image-20240421200505175](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404212005482.png)

- **设置带过期时间的值 (毫秒为单位)**：

  ```
  PSETEX key millisecond value
  ```

  ![image-20240421200637005](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404212006065.png)

- **设置一个或多个key-value对**：

  ```redis
  MSET key value[key value ...]
  ```

  ![image-20240421200800258](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404212008927.png)

- **当且仅当key不存在，设置一个或多个key-value对**：

  ```redis
  MSETNX key value[key value ...]
  ```

  ![image-20240421201050706](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404212010413.png)

- **更新字符串值 (从偏移量offset开始)**：offset 被修改后的字符串长度。

  ```redis
  SETRANGE key offset value
  ```

  ![image-20240421202800054](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404212028503.png)

- **获取指定key的值**：

  ```redis
  GET key
  ```

  ![image-20240421203104362](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404212031919.png)

- **获取key中字符串值的子字符**：

  ```redis
  GETRANGE key start end
  ```

  ![image-20240421203222326](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404212032422.png)

- **获取所有 (一个或多个) key的值**：

  ```redis
  MGET key1 [key2 ...]
  ```

  ![image-20240421203447524](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404212034542.png)

- **设置key的值，并返回key的旧值**：

  ```redis
  GETSET key value
  ```

  ![image-20240421203729396](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404212037446.png)

- **设置或清除指定偏移量的字符串的值**：指定偏移量原来储存的位

  ```redis
  SETBIT key offset value
  ```

  ![image-20240421202317817](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404212023188.png)

- **获取指定偏移量的位**：

  ```redis
  GETBIT key offset
  ```

  ![image-20240421202317817](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404212023188.png)

- **获取字符串长度**：

  ```redis
  STRLEN key
  ```

  ![image-20240421203843624](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404212038830.png)

- **内容追加**：key已经存在并且是一个字符串，会将内容加到原有值的末尾，不存在的 key 进行 APPEND ，等同于 SET

  ```redis
  APPEND key value
  ```

  ![image-20240421204319106](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404212043321.png)

- **数值增1**：

  ```redis
  INCR key
  ```

  ![image-20240421204820302](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404212048854.png)

- **数值加**：

  ```redis
  INCRBY key increment
  ```

  ![image-20240421204913497](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404212049121.png)

- **数值加 (加浮点数)**：

  ```redis
  INCRBYFLOAT key increment
  ```

  ![image-20240421205020279](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404212050812.png)

- **数值减1**：

  ```redis
  DECR key
  ```

  ![image-20240421205119441](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404212051691.png)

- **数值减**：

  ```redis
  DECRBY key decrement
  ```

  ![image-20240421205228281](https://cdn.jsdelivr.net/gh/letengzz/tc2@main/img202404212052361.png)

