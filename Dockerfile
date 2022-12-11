FROM python:3.10.6-slim-buster

RUN apt update && apt-get install gcc automake autoconf libtool make -y
ADD requirements.txt ./
RUN pip install -r requirements.txt

RUN mkdir -p /app
ADD . /app
WORKDIR /app

ENTRYPOINT [ "make", "run" ]