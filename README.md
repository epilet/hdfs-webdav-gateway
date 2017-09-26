hdfs-webdav-gateway
===================

hdfs-webdav-gateway is an nginx deployment that serves HDFS via webdav.

Your docker host needs to load the `fuse` kernel module, and the container has to be privileged.

```
docker pull epilet/hdfs-webdav-gateway
```
