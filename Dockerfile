FROM node:alpine as builder

ENV YAPI_VERSION=1.8.5

RUN set -x \
    && echo 'https://mirrors.ustc.edu.cn/alpine/v3.9/main'>/etc/apk/repositories \
    && echo 'https://mirrors.ustc.edu.cn/alpine/v3.9/community'>>/etc/apk/repositories \
    && apk update \
    && apk upgrade \
    && apk add --no-cache git python make openssl tar gcc \
    && wget -O yapi.tgz http://registry.npm.taobao.org/yapi-vendor/download/yapi-vendor-$YAPI_VERSION.tgz \
    && tar zxf yapi.tgz -C /home/ \
    && mkdir /api \
    && mv /home/package /api/vendors \
    && cd /api/vendors \
    && npm install --production --registry https://registry.npm.taobao.org




FROM node:alpine

LABEL maintainer="Storezhang<storezhang@gmail.com>"
LABEL architecture="AMD64/x86_64" version="latest" build="2019-11-29"
LABEL Description="基于Alpine的最新YAPI打包。"

ENV TZ="Asia/Shanghai" HOME="/"
ENV LANG="zh_CN.UTF-8"
ENV TIMEZONE=/Asia/Chongqing

WORKDIR ${HOME}

COPY --from=builder /api/vendors /api/vendors
COPY config.json /api/

RUN set -x \
    && echo 'https://mirrors.ustc.edu.cn/alpine/v3.9/main'>/etc/apk/repositories \
    && echo 'https://mirrors.ustc.edu.cn/alpine/v3.9/community'>>/etc/apk/repositories \
    && apk update \
    && apk --no-cache add tzdata \
    && cp "/usr/share/zoneinfo/${TIMEZONE}" /etc/localtime \
    && echo "${TIMEZONE}" > /etc/timezone \
    && echo "export LC_ALL=${LANG}" >> /etc/profile \
    && rm -rf /var/cache/apk/*

EXPOSE 23100

ENTRYPOINT ["node"]
