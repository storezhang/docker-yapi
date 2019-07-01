FROM node:alpine as builder

ENV YAPI_VERSION=1.7.0

RUN set -x \
    && echo 'https://mirrors.ustc.edu.cn/alpine/v3.9/main'>/etc/apk/repositories \
    && echo 'https://mirrors.ustc.edu.cn/alpine/v3.9/community'>>/etc/apk/repositories \
    && apk update \
    && apk upgrade \
    && apk add --no-cache git python make openssl tar gcc \
    && wget -O yapi.tgz http://registry.npm.taobao.org/yapi-vendor/download/yapi-vendor-$YAPI_VERSION.tgz \
    && tar zxvf yapi.tgz -C /home/ \
    && mv /home/package /api/vendors \
    && cd /api/vendors \
    && npm install --production --registry https://registry.npm.taobao.org




FROM node:alpine

LABEL maintainer="Storezhang<storezhang@gmail.com>"

ENV TZ="Asia/Shanghai" HOME="/"
WORKDIR ${HOME}

COPY --from=builder /api/vendors /api/vendors
COPY config.json /api/

EXPOSE 23100

ENTRYPOINT ["node"]
