# 第一阶段：构建/整理阶段
FROM alpine AS builder

# 设置工作目录
WORKDIR /app

COPY src .

COPY src/.env ./copy/.env
COPY src/.env ./env/.env
COPY src/storage ./copy/storage

RUN rm -rf .env

RUN ln -s env/.env .env

FROM php:8.2-fpm


# 安装 PHP 扩展安装器
ADD --chmod=0755 https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

# 安装 Nginx 和 Supervisor 和 php 扩展
RUN apt-get update && \
    apt-get install -y nginx supervisor && \
    rm -rf /var/lib/apt/lists/* && \
    install-php-extensions pdo_mysql gd zip imagick

# 复制 nginx 配置
COPY nginx.conf /etc/nginx/nginx.conf

# 复制php配置
COPY www.conf /usr/local/etc/php-fpm.d/zz-docker.conf

COPY php.ini /usr/local/etc/php/php.ini

# 复制 Supervisor 配置
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# 清理nginx目录
RUN rm -rf /var/www/html/*

# COPY src /var/www/html/

COPY --from=builder /app /var/www/html/

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN chown -R www-data:www-data /var/www/html

RUN mkdir -p /path/to/unix && chown -R www-data:www-data /path/to/unix

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
