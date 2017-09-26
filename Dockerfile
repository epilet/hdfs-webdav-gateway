FROM ubuntu:latest
ENV LD_LIBRARY_PATH=/usr/lib/jvm/default-java/jre/lib/amd64:/usr/lib/jvm/default-java/jre/lib/amd64/server
RUN apt-get update && apt-get install -y wget apt-transport-https default-jre nginx-extras kmod
RUN wget http://archive.cloudera.com/cdh5/one-click-install/trusty/amd64/cdh5-repository_1.0_all.deb
RUN dpkg -i cdh5-repository_1.0_all.deb
RUN apt-get update && apt-get install --allow-unauthenticated -y hadoop-hdfs-fuse
COPY nginx.conf /etc/nginx/
ADD bootstrap.sh /
ENTRYPOINT ["/bootstrap.sh"]
