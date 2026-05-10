#!/bin/sh

# --- 创建 PHP-FPM socket 目录 ---
mkdir -p /path/to/unix && chown www-data:www-data /path/to/unix

# --- 处理 env 文件夹 ---
# 检查 /var/www/html/env 目录下是否有 .env 文件
if [ ! -f /var/www/html/env/.env ]; then
    echo "检测到 env 文件夹为空或缺失 .env，正在从备份恢复..."
    mkdir -p /var/www/html/env
    cp /var/www/html/copy/.env /var/www/html/env/.env
fi

# --- 处理 storage 文件夹 ---
# 检查 /var/www/html/storage 是否为空（-A 表示除了 . 和 .. 以外是否有文件）
if [ ! "$(ls -A /var/www/html/storage 2>/dev/null)" ]; then
    echo "检测到 storage 文件夹为空，正在从备份恢复内容..."
    mkdir -p /var/www/html/storage
    # 使用 cp -a 保持权限和递归复制
    cp -a /var/www/html/copy/storage/. /var/www/html/storage/
fi

# --- 权限修正 (可选但推荐) ---
# 确保 web 服务对这些文件夹有写入权限
chown -R www-data:www-data /var/www/html/env /var/www/html/storage

# --- 启动主程序 ---
# 这行很重要，它会运行 Docker 镜像原本默认的命令（如 apache2-foreground）
exec "$@"