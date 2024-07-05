# Windows 卸载

## 停止服务

【计算】-->右键-->【管理】-->【服务】-->【mysql的服务】-->【停止】

![image-20211127131123822](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042023652.png)

## 软件的卸载

### 通过控制面板卸载

![image-20210727180032098](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042026106.png)

![image-20211127105018580](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042027227.png)

### 通过mysql8的安装向导卸载

1. 双击mysql8的安装向导

   ![image-20211127111201381](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042030766.png)

2. 取消更新

   ![image-20211127111141171](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042030683.png)

   ![image-20211127111248477](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042031986.png)

3. 选择要卸载的mysql服务器软件的具体版本

   ![image-20211127111636535](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042031378.png)

   ![image-20211127111756888](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042032567.png)

4. 确认删除数据目录

   ![image-20211127111904711](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042033737.png)

5. 执行删除

   ![image-20211127112049612](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042033454.png)

   ![image-20211127112146641](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042033632.png)

6. 完成删除

   ![image-20211127112224983](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042034055.png)

   ![image-20211127112303454](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042034215.png)


## 清理残余文件

如果卸载后还有残余文件，先对残余文件进行清理后再安装。

1. 服务目录：mysql服务的安装目录
2. 数据目录：如果没有指定过默认在C:\ProgramData\MySQL

如果自己单独指定过，就找到自己的数据目录，例如安装时指定过如下目录：

![img](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042035368.jpg)

## 清理服务列表中的服务名

在windows操作系统，卸载后mysql后，服务没有卸载干净，可以通过系统管理员在cmd命令行删除服务。

![image-20211127131325742](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042036599.png)

```
sc  delete  服务名
```

![image-20211127131515955](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042035220.png)

## 清理原来的环境变量

找到path环境变量，将其中关于mysql的环境变量删除即可，**切记<font color='red'>不要</font>把整个path删除。**

例如：删除  D:\ProgramFiles\MySQL\MySQLServer8.0_Server\bin;  这个部分

![image-20211127113140430](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042036956.png)

![image-20211127113205093](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042037633.png)

![image-20211127113258108](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042037772.png)

![image-20211127113327805](https://cdn.jsdelivr.net/gh/letengzz/tc2/img/202407042037797.png)

## 清理注册表

打开注册表编辑器：在系统的搜索框中输入regedit

* HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\Eventlog\Application\MySQL服务 目录删除

* HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\MySQL服务 目录删除

* HKEY_LOCAL_MACHINE\SYSTEM\ControlSet002\Services\Eventlog\Application\MySQL服务 目录删除

* HKEY_LOCAL_MACHINE\SYSTEM\ControlSet002\Services\MySQL服务 目录删除

* HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Eventlog\Application\MySQL服务目录删除

* HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\MySQL服务删除

> 注册表中的ControlSet001,ControlSet002,不一定是001和002,可能是ControlSet005、006之类