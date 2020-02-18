# centosphp7.4


[![centOS8.1](https://img.shields.io/badge/centOS-8.1-green.svg)]()
[![php7.4.3](https://img.shields.io/badge/php-7.4.3-blue.svg)]()



## 可以自己生成镜像

### 1.克隆文件到本地
    $ git clone https://github.com/pqshawn/centosphp7.4.git

### 2.建立镜像

    $ docker build -t php7.4 .

### 3.启动

    $ docker run -d --name php-fpm -p 9000:9000 -v /data/www:/data/www  php7.4


## 可以直接拉取镜像
如果有阿里云账号，可以直接pull

### 1. 登录阿里云Docker Registry
    $ sudo docker login --username=xxx@xxx.com registry.cn-shanghai.aliyuncs.com
    用于登录的用户名为阿里云账号全名，密码为开通服务时设置的密码。

    您可以在访问凭证页面修改凭证密码。

### 2. 从Registry中拉取镜像
    $ sudo docker pull registry.cn-shanghai.aliyuncs.com/ldos/centosphp7.4


### 3.启动
    docker run -d --name php-fpm -p 9000:9000 -v /data/www:/data/www  php7.4

## 配合nginx使用
    建议尽量不整合镜像在一块，一个服务只做一件事
    nginx单独下载，直接下载官方版本

    $ docker pull nginx

    $ docker run --name nginx --link php-fpm:php-fpm  -p 80:80 -v /data/www:/usr/share/nginx/html -v /var/3h3d/nginx/conf.d:/etc/nginx/conf.d  -d nginx

    /data/www 是宿主机的项目目录
    /var/3h3d/nginx/conf.d 是宿主机的nginx配置目录
    分别作下映射
