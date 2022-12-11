FROM uselagoon/python-3.9

RUN mkdir -p /app
ADD . /app
WORKDIR /app
ENTRYPOINT [ "make", "run" ]