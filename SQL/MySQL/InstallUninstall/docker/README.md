# Docker 安装

1. 拉取镜像：

   ```shell
   docker pull mysql:8.0.30
   ```

2. 使用容器启动服务：

   ```shell
   docker run --name docker_mysql --restart=always -v D:/Data/mysql:/var/lib/mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root -d mysql:8.0.30
   ```