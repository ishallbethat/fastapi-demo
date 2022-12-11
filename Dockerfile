FROM python:3.10.6-slim-buster

RUN mkdir -p /app
ADD . /app
WORKDIR /app
ENTRYPOINT [ "make", "run" ]