#!/bin/sh

# --- 创建 PHP-FPM socket 目录 ---
mkdir -p /path/to/unix && chown www-data:www-data /path/to/unix

# --- 处理 data 文件夹 ---
# 定义变量，方便后续维护
DATA_DIR="/var/www/html/data"
BACKUP_DIR="/var/www/html/copy"

# 如果目录不存在，或者目录存在但是为空
if [ ! -d "$DATA_DIR" ] || [ -z "$(ls -A "$DATA_DIR" 2>/dev/null)" ]; then
    echo "检测到 data 文件夹为空或不存在，正在从备份恢复..."
    mkdir -p "$DATA_DIR"
    cp -a "$BACKUP_DIR"/.* "$BACKUP_DIR"/* "$DATA_DIR"/ 2>/dev/null
    echo "恢复完成！"
fi



# --- 权限修正 (可选但推荐) ---
# 确保 web 服务对这些文件夹有写入权限
chown -R www-data:www-data /var/www/html

# --- 启动主程序 ---
# 这行很重要，它会运行 Docker 镜像原本默认的命令（如 apache2-foreground）
exec "$@"