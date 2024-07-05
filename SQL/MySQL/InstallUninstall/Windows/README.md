

# Windows 安装

## 安装 MySQL

**注意**：

1. 必须用系统管理员身份运行mysql安装程序。
2. 安装目录切记不要用中文。

****

**操作步骤**：

1. 下载地址：https://dev.mysql.com/downloads/mysql/

   **说明**："GA" 是 "General Availability" 的缩写，通常表示软件的正式发布版本，即最新的稳定版本。

   ![image-20240704201822707](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042145890.png)

2. 双击mysql8的安装向导：

   ![image-20211127111201381](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042053260.png)

3. 首次安装/再安装：

   **首次安装**：如果是首次安装mysql系列的产品，需要先安装mysql产品的安装向导：

   ![](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042108902.jpg)

   选择安装模式：

   ![image-20211128175722806](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042109602.png)

   **不是首次安装**：

   取消更新 (如果电脑上有mysql相关软件才有)

   ![image-20211127113631758](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042110859.png)

   ![image-20211127111248477](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042111200.png)

   选择Add安装

   ![image-20211127113738546](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042111503.png)

4. 选择要安装的产品

   ![image-20211127114653481](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042115855.png)

   ![image-20211127114719245](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042116253.png)![image-20211127114744905](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042116730.png)

5. 设置软件安装目录：切记服务安装目录不要有中文字符，否则有问题

   ![image-20211127115035455](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042120153.png)

   ![image-20211127115150647](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042120417.png)

   ![image-20211127115242110](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042121655.png)

   ![image-20211127115529359](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042121953.png)

   ![image-20211127115719270](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042121248.png)

6. 执行安装

   ![image-20211127115748337](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042121443.png)

   ![image-20211127115812289](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042122386.png)

7. 完成安装

   ![image-20211127115844966](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042122066.png)

8. 准备设置

   ![image-20211127120041368](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042122723.png)

## MySQL实例初始化和设置

1. 选择安装的电脑类型、设置端口号

   ![image-20211127120247934](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042134507.png)

   ![image-20211127120515458](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042134995.png)

2. 选择mysql账号密码加密规则

   在MySQL 5.x中默认的身份认证插件为"mysql_native_password"。

   在MySQL 8.x中，默认的身份认证插件是"caching_sha2_password"，替代了之前的"mysql_native_password"。

   ![image-20211127120743104](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042135201.png)

3. 设置root账户密码

   ![image-20211127121133127](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042135717.png)

4. 设置mysql服务名和服务启动策略

   如果电脑上可能安装多个版本mysql，请在服务名后面保留版本标识，例如：MySQL80，这样可以区别用哪个版本的mysql

   ![image-20211127121615732](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042136626.png)

5. 执行设置(初始化mysql实例)

   ![image-20211127121929986](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042136426.png)

   ![image-20211127122012517](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042136457.png)

6. 完成设置

   ![image-20211127122037556](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042136743.png)

   ![image-20211127122105747](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042137680.png)

   ![image-20211127122124855](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042137789.png)

   ![image-20211127130231815](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042137691.png)

## MySQL数据库服务的启动和停止

MySQL软件的服务器端必须先启动，客户端才可以连接和使用使用数据库。

如果接下来天天用，可以设置自动启动。

1. 图形化方式

   * 计算机(点击鼠标右键) --> 管理(点击) --> 服务和应用程序(点击) --> 服务(点击) --> MySQL80(点击鼠标右键) --> 启动或停止(点击)

   * 控制面板(点击) --> 系统和安全(点击) --> 管理工具(点击) --> 服务(点击) --> MySQL80(点击鼠标右键) --> 启动或停止(点击)

   * 任务栏(点击鼠标右键) --> 启动任务管理器(点击) --> 服务(点击) --> MySQL80(点击鼠标右键) --> 启动或停止(点击)


2. 命令行方式必须是系统管理员才能运行下面的命令：

   启动 MySQL 服务命令：

   ```mysql
   net start MySQL80
   ```

   停止 MySQL 服务命令：

   ```mysql
   net stop MySQL80
   ```

## MySQL数据库环境变量的配置

如果运行mysql命令，报错如下错误，说明需要配置环境变量

![image-20211128172817265](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042113338.png)

![image-20211127133531030](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042113263.png)

| 环境变量名 | 操作 |                 环境变量值                  |
| :--------: | :--: | :-----------------------------------------: |
| MYSQL_HOME | 新建 | D:\ProgramFiles\MySQL\MySQLServer8.0_Server |
|    path    | 编辑 |              %MYSQL_HOME%\bin               |

或者直接

| 环境变量名 | 操作 |                   环境变量值                    |
| :--------: | :--: | :---------------------------------------------: |
|    path    | 编辑 | D:\ProgramFiles\MySQL\MySQLServer8.0_Server\bin |

![image-20211127165256909](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042113976.png)

