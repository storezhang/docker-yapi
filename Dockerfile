FROM node:alpine as builder

ENV VERSION=1.7.0

RUN apk add --no-cache git python make openssl tar gcc
RUN wget -O yapi.tgz http://registry.npm.taobao.org/yapi-vendor/download/yapi-vendor-$VERSION.tgz \
    && tar zxvf yapi.tgz -C /home/ \
    && mkdir /api \
    && mv /home/package /api/vendors \
    && cd /api/vendors \
    && npm install --production --registry https://registry.npm.taobao.org



FROM node:alpine

MAINTAINER storezhang@gmail.com

ENV TZ="Asia/Chongqing" HOME="/"
WORKDIR ${HOME}
COPY --from=builder /api/vendors /api/vendors
COPY config.json /api/
EXPOSE 23100

ENTRYPOINT ["node"]