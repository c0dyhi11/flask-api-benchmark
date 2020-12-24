FROM python:3.8-slim
COPY ./*.* /app/

WORKDIR /app

RUN bash install-nginx.sh

RUN set -ex \
    && BUILD_DEPS=" \
    build-essential \
    libpcre3-dev \
    libpq-dev \
    " \
    && apt-get update && apt-get install -y --no-install-recommends supervisor $BUILD_DEPS \
    && pip install --no-cache-dir -r requirements.txt \
    \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false $BUILD_DEPS \
    && rm -rf /var/lib/apt/lists/*

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx_server.conf /etc/nginx/conf.d/nginx.conf

ENTRYPOINT [ "/usr/bin/supervisord" ]

