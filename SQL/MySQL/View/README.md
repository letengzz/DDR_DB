# 视图

视图 (View) 是一种虚拟存在的表。**视图中的数据并不在数据库中实际存在**，**行和列数据来自创建视图的查询中使用的表**（基表），并且是在使用视图时**动态生成**的。 也就是说,视图**其本身只是一段查询的SQL逻辑**。

![image-20240708225653749](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202407082257430.png)

视图也是一张数据库表，当创建以后，也可以像操作正常数据库一样操作它。其用途：

- 可以简化用户对数据的理解和操作。那些被经常使用的复杂多表查询可以被定义为视图，从而避免以后的操作每次都需指定全部的条件。
- 数据库可以授权，但不能授权到数据库特定行和特定的列上。配合视图使用可以限制用户只能查询和修改他们所能见到的数据
- 视图可帮助用户屏蔽真实表结构变化带来的影响。

## 创建视图

语法：

```sql
CREATE [OR REPLACE] VIEW 视图名称[(列名列表)] AS SELECT 语句 [ WITH [ CASCADED | LOCAL ] CHECK OPTION ]
```

![image-20240708225954682](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202407082259335.png)

## 操作数据

视图也是一张表，可以像操作正常表一样操作视图。

**例**：查询视图所有数据

![image-20240708230044292](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202407082300619.png)

## 修改视图

语法：

- 方式一：`CREATE OR REPLACE` 不存在则创建， 存在则替换

  ```sql
  CREATE OR REPLACE VIEW 视图名称[(列名列表)] AS SELECT语句 [ WITH [ CASCADED | LOCAL ] CHECK OPTION ]
  ```

  ![image-20240708230523180](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202407082305739.png)

- 方式二：

  ```sql
  ALTER VIEW  视图名称[(列名列表)] AS SELECT语句 [ WITH [ CASCADED | LOCAL ] CHECK OPTION ]
  ```

  ![image-20240708230731426](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202407082307623.png)

## 删除视图

语法：若同时删除多张视图，以逗号分割：`[,视图名称]` 

```sql
DROP VIEW [IF EXISTS] 视图名称 [,视图名称]
```

![image-20240708230957547](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202407082309286.png)

## 查看创建视图

语法：

```sql
SHOW  CREATE  VIEW  视图名称
```

除了所指定的参数，还有一堆默认配置
![image-20240708231106483](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202407082311236.png)

## 检查选项

由于视图是虚拟存在的表，对视图的操作都会反应到基表当中，假设对视图表插入不符合视图where条件的数据，那么这条数据只会存在于基表当中，而在视图表无法获悉，但在基表中存在。

![image-20240709131432358](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202407091314954.png)

在创建或修改视图的语句中可以看到`WITH CHECK OPTION`选项，MySQL会通过视图检查正在更改的每个行，例如 插 入，更新，删除，对于满足条件（例如where条件）的操作，允许，否则禁止，以使其符合视图的定义。 由于MySQL**允许基于另一个视图创建视图**，因此它还会检查依赖视图中的规则以保持一致性。为了确定检查的范围，mysql提供了两个选项： `CASCADED` 和 `LOCAL` ，**默认值**为 `CASCADED` 。

### CASCADED级联

假设v2视图是基于v1视图的，如果在v2视图创建的时候指定了检查选项为 `cascaded`，v1视图 创建时未指定检查选项（如果指定了则继续检查上一级，以此往复）。 则在对v2进行操作执行检查时，不仅会检查v2，还会级联检查v2的关联视图v1，如果不满足条件则无法进行相关操作。

![image-20240709133126127](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202407091331733.png)

`u2`插入失败示例

![image-20240709133739453](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202407091337988.png)

`u2`插入成功

![image-20240709205725131](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202407092057044.png)

`u1`插入情况

![image-20240709210915798](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202407092109496.png)

### LOCAL本地

与上述类似，LOCAL也会递归的去寻找当前视图所依赖的视图。不同的是，如果当前视图或者依赖的视图后面定义了`with check option`检查选项才会校验操作的数据是否满足该视图的条件(where)，否则不会校验。

![image-20240709214532284](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202407092145811.png)

依赖视图未定义检查选项

![image-20240709220324083](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202407092203392.png)

依赖视图定义了检查选项
![image-20240709220938280](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202407092209410.png)

## 视图更新

要使视图可更新，**视图中的行与基础表中的行之间必须存在一对一的关系**。如果视图包含以下任何一 项，则该视图不可更新：

- 聚合函数或窗口函数 (`SUM()`、 `MIN()`、 `MAX()`、 `COUNT()`等)
- DISTINCT
- GROUP BY
- HAVING
- UNION 或者 UNION ALL

**例**：创建视图时使用了聚合函数，破坏了一对一关系

```sql
create view user_v_count as select count(*) from user;
```

如果对这个视图进行更新或插入的，将会报错。

```sql
insert into user_v_count values(10);
```

![image-20240708231329421](https://cdn.jsdelivr.net/gh/letengzz/tc2/img202407082313636.png)