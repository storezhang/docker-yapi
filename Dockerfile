FROM node:alpine

LABEL maintainer="Storezhang<storezhang@gmail.com>"

ENV YAPI_VERSION=1.7.0
ENV YAPI_HOME=/opt/yapi

COPY config.json ${YAPI_HOME}/
EXPOSE 23100

WORKDIR ${YAPI_HOME}
VOLUME ${YAPI_HOME}

RUN set -x \
    && echo 'https://mirrors.ustc.edu.cn/alpine/v3.9/main'>/etc/apk/repositories \
    && echo 'https://mirrors.ustc.edu.cn/alpine/v3.9/community'>>/etc/apk/repositories \
    && apk update \
    && apk upgrade \
    && apk add --no-cache git python make openssl tar gcc \
    && wget -O yapi.tgz http://registry.npm.taobao.org/yapi-vendor/download/yapi-vendor-$YAPI_VERSION.tgz \
    && tar zxvf yapi.tgz -C /home/ \
    && rm -rf yapi.tgz \
    && mkdir ${YAPI_HOME} \
    && mv /home/package ${YAPI_HOME}/vendors \
    && cd ${YAPI_HOME}/vendors \
    && npm install --production --registry https://registry.npm.taobao.org

ENTRYPOINT ["node"]
