FROM python:3.10.6-slim-buster AS builder-image

RUN apt update && apt-get install gcc automake autoconf libtool make python3-venv -y

RUN mkdir -p /app && python -m venv /app/venv
ENV PATH="/app/venv/bin:$PATH"
COPY requirements.txt .
RUN pip3 install --no-cache-dir wheel
RUN pip3 install --no-cache-dir -r requirements.txt



FROM python:3.10.6-slim-buster AS runner-image
RUN apt update && apt-get install gcc automake autoconf libtool make python3-venv -y
RUN mkdir -p /app
COPY --from=builder-image /app/venv /app/venv
ENV VIRTUAL_ENV=/app/venv
ENV PATH="/app/venv/bin:$PATH"
WORKDIR /app
COPY . .
EXPOSE 8000
WORKDIR /app
ENTRYPOINT [ "make", "run" ]