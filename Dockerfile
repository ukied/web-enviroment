# Copyright (c) 2022 present International Economic Develpment Limited
# docker buildx build -t zhukainet/environment:app --platform=linux/arm,linux/arm64,linux/amd64 . --push

FROM python:3.10-bullseye

MAINTAINER kai.zhu "zhukai@zhukai.net"

WORKDIR /python-docker

## 修改镜像源 Start （国外主机可直接删除以下Start~End之间部分）
## 修改系统镜像源
RUN sed -i 's/deb.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list
## 修改PIP镜像源
RUN pip config set global.index-url http://mirrors.aliyun.com/pypi/simple
RUN pip config set install.trusted-host mirrors.aliyun.com
## 修改镜像源 End

# 增加db支持
RUN apt-get update
RUN apt-get install -y gcc
RUN apt-get install -y python3-mysqldb default-libmysqlclient-dev
## 增加其他支持
#RUN apt-get install -y --reinstall build-essential
#RUN apt-get install -y libffi-dev libtiff-dev

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt


#COPY <src> <dest>
COPY . .

# 暴露 80 端口，给外部使用
EXPOSE 80

#CMD ["python3", "./app.py"]
CMD ["gunicorn", "-c", "gunicorn.conf.py", "server:app"]
