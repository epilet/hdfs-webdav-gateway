#!/bin/bash

mkdir -p /hdfs
chown 777 -R /hdfs
hadoop-fuse-dfs dfs://$HDFS_NAMENODE_HOST /hdfs
nginx -g "daemon off;"
