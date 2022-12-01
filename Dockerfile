# Copyright (c) 2022 present Kai.Zhu
# Support WSL & aplpine

FROM python:3.10-alpine

MAINTAINER kai.zhu "zhukai@zhukai.net"

WORKDIR /python-docker

## 修改镜像源 Start （国外主机可直接删除以下Start~End之间部分）
## 修改APK镜像源
## Alphine
#RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories
## 修改PIP镜像源
#RUN pip config set global.index-url http://mirrors.aliyun.com/pypi/simple
#RUN pip config set install.trusted-host mirrors.aliyun.com
## 修改镜像源 End

# 增加mariadb支持
RUN apk add libffi-dev build-base gcc musl-dev
RUN apk add mariadb-connector-c-dev
RUN apk add freetype-dev
#RUN apt-get install -y gcc python3-dev default-libmysqlclient-dev

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

#COPY <src> <dest>
COPY . .

# 暴露 5550 端口，给外部使用
EXPOSE 5550

#CMD ["python3", "./app.py"]
CMD ["gunicorn", "-c", "gunicorn.conf.py", "server:app"]
