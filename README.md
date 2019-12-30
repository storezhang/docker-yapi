# yapi
[![Build Status](https://cloud.drone.io/api/badges/storezhang/docker-yapi/status.svg)](https://cloud.drone.io/storezhang/docker-yapi)

YAPI服务，使用Docker运行，一套解决方案

## 例子
-----------------------
初始化数据库
```bash
sudo docker run -it --rm \
  --link mongo:mongo \
  --entrypoint npm \
  --workdir /api/vendors \
  --volume /volume1/docker/yapi/config.json:/api/config.json \
  storezhang/yapi \
  run install-server
```
---------------------
启动服务
```bash
sudo docker run -d \
  --name yapi \
  --link mongo:mongo \
  --workdir /api/vendors \
  --volume /volume1/docker/yapi/config.json:/api/config.json:ro \
  -p 23100:23100 \
  storezhang/yapi \
  server/app.js
```