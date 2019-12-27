# yapi
[![Build Status](https://drone.storezhang.imyserver.com:20443/api/badges/storezhang/docker-yapi/status.svg)](https://drone.storezhang.imyserver.com:20443/storezhang/docker-yapi)

YAPI服务，使用Docker运行。

## 例子
-----------------------
初始化数据库
```bash
sudo docker run -it --rm \
  --link mongo:mongo \
  --entrypoint npm \
  --workdir /api/vendors \
  --volume /volume1/docker/yapi/config.json:/api/config.json \
  storezhang/yapi:1.7.0.3 \
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
  storezhang/yapi:1.7.0.3 \
  server/app.js
```