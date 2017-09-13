#!/bin/bash

. env.sh
. config-default.sh

#启动docker
function startdocker(){
    docker stop  $containerName
    docker rm -f $containerName
    docker run -d -p 3002:3002 -e MYSQL_CONN=$MYSQL_CONN -e ADDRESS=$ADDRESS --name $containerName -d $imageName
}

#构建docker镜像
function builddocker(){
   GOOS=linux GOARCH=amd64 go build -o main
   docker build -t $imageName .
}
#启动测试
function starttesting(){
    go test -v ./service/
}
#生成thrift文件
function creatthrift(){
    echo "正在生成thrift文件"
    thrift -r --gen php -out "$phpdir" $thriftfile
    thrift -r --gen go -out "$GOPATH/src" $thriftfile
}
#启动本地服务
function startlocal(){
    creatthrift
    rm -rf main
    echo 编译中...
    go build -o main
    chmod +x main
    echo "编译完成,启动服务器"
    ./main
}

if [ "$1" = "startdocker" ];then
    echo "start docker"
    startdocker
elif [ "$1" == "test" ];then
    echo "start testing"
    starttesting
elif [ "$1" == "builddocker" ];then
    echo "docker build"
    builddocker
elif [ "$1" == "thrift" ];then
    creatthrift
elif [ "$1" == "local" ];then
    startlocal
fi
