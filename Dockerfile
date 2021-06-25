FROM node:alpine as builder

ENV YAPI_VERSION=1.9.2

RUN set -x
RUN apk update
RUN apk upgrade
RUN apk add --no-cache git python2 make openssl tar gcc
RUN wget -O yapi.tgz http://registry.npm.taobao.org/yapi-vendor/download/yapi-vendor-$YAPI_VERSION.tgz
RUN tar zxf yapi.tgz -C /home/
RUN mkdir /api
RUN mv /home/package /api/vendors
RUN cd /api/vendors
RUN npm install --production --registry https://registry.npm.taobao.org




FROM node:alpine

LABEL maintainer="Storezhang<storezhang@gmail.com>"
LABEL architecture="AMD64/x86_64" version="latest" build="2021-06-25"
LABEL Description="基于Alpine的最新Yapi打包"

ENV TZ="Asia/Shanghai" HOME="/"
ENV LANG="zh_CN.UTF-8"
ENV TIMEZONE=/Asia/Chongqing

WORKDIR ${HOME}

COPY --from=builder /api/vendors /api/vendors
COPY config.json /api/

RUN set -x \
    && apk update \
    && apk --no-cache add tzdata \
    && cp "/usr/share/zoneinfo/${TIMEZONE}" /etc/localtime \
    && echo "${TIMEZONE}" > /etc/timezone \
    && echo "export LC_ALL=${LANG}" >> /etc/profile \
    && rm -rf /var/cache/apk/*

EXPOSE 23100

ENTRYPOINT ["node"]
