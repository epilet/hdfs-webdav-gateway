hdfs-webdav-gateway
===================

hdfs-webdav-gateway is an nginx deployment that serves HDFS via webdav.

Your docker host needs to load the `fuse` kernel module, and the container has to be privileged.


## How to get the docker image

```
docker pull epilet/hdfs-webdav-gateway
```

## Example: deployment on Kubernetes

```
---
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: webdav
  annotations:
    ingress.kubernetes.io/whitelist-source-range: '1.2.3.4/16'
    ingress.kubernetes.io/proxy-body-size: 64000m
spec:
  rules:
    - host: hdfs-webdav-gateway.abc.com
      http:
        paths:
          - path: /
            backend:
              serviceName: webdav
              servicePort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: webdav
  labels:
    app: webdav
spec:
  ports:
  - port: 80
    targetPort: 8080
    name: webdav
  selector:
    app: webdav
---
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: webdav
spec:
  template:
    metadata:
      labels:
        app: webdav
    spec:
      restartPolicy: Always
      containers:
        - name: webdav
          image: epilet/hdfs-webdav-gateway:latest
          env:
            - name: HDFS_NAMENODE_HOST
              value: namenode-host:8020
          ports:
            - containerPort: 8080
              name: webdav
          securityContext:
            privileged: true
            capabilities:
              add: ["SYS_ADMIN"]
          volumeMounts:
            - mountPath: /dev/
              name: dev
            - mountPath: /lib/modules/
              name: modules
      volumes:
        - name: dev
          hostPath:
            path: /dev/
        - name: modules
          hostPath:
            path: /lib/modules/
```
