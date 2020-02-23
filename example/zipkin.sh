#!/bin/bash

if [ 1 ]; then
    java=`which java`
    
    if [ -z "$java" ]; then
        echo "can not find java"    
        exit;
    fi
    
    if [ ! -f zipkin.jar ]; then
        curl -sSL https://zipkin.io/quickstart.sh | bash -s
    fi
    export STORAGE_TYPE=mem
    export HTTP_COLLECTOR_ENABLE=true
    
    zipkin=`ps aux|grep zipkin.jar|grep -v grep`
    
    if [ -z "$zipkin" ]; then
        java -jar zipkin.jar --logging.level.zipkin=DEBUG 2>&1 >/dev/null &
    sleep 3
    fi
else
    image=`docker images --format "{{.ID}}:{{.Repository}}"|grep zipkin`

    if [ -z "$image" ]; then
        docker pull docker.io/openzipkin/zipkin:last
    fi

    running=`docker ps --format "{{.ID}}\t{{.Image}}"|grep zipkin`
    if [ -z "$running" ]; then
        docker run -d -p 9411:9411 openzipkin/zipkin     
    fi
fi
