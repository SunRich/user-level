#!/bin/bash

export MYSQL_CONN="root:root@tcp(192.168.118.174:3306)/taxation?charset=utf8&parseTime=True&loc=Asia%2FShanghai" #数据库地址
export TEST_MYSQL_CONN="root:root@tcp(192.168.118.174:3306)/taxation?charset=utf8&parseTime=True&loc=Asia%2FShanghai" #测试数据库
export TEST_MIGRATE_CONN="root:root@tcp(192.168.118.174:3306)/taxation?multiStatements=true" #数据库迁移配置文件
export ADDRESS="0.0.0.0:3002" #开启的服务ip地址，加上端口
phpdir=~/work/web/kaoyayacn/ #生成thrift-php版本代码地址
