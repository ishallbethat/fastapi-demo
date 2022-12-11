FROM python:3.8.10-slim

RUN mkdir -p /app
ADD . /app
WORKDIR /app
ENTRYPOINT [ "make", "run" ]