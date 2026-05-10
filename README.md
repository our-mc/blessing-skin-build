# Blessing Skin Build

Blessing Skin Server 的构建配置项目，包含开发环境和生产环境的 Docker 配置。

## 项目结构

```
blessing-skin-build/
├── .github/workflows/    # GitHub Actions 工作流配置
│   └── build.yml         # 构建工作流
├── dev/                  # 开发环境配置
│   ├── Dockerfile
│   ├── entrypoint.sh
│   ├── nginx.conf
│   ├── php.ini
│   ├── supervisord.conf
│   └── www.conf
├── master/               # 生产环境配置
│   ├── Dockerfile
│   ├── entrypoint.sh
│   ├── nginx.conf
│   ├── php.ini
│   ├── supervisord.conf
│   └── www.conf
├── compose.yaml          # Docker Compose 配置
├── LICENSE
└── README.md
```

## 使用方法

### 开发环境

开发环境位于 `dev/` 目录，适用于本地开发和测试。

```bash
# 使用 Docker Compose 启动开发环境
docker-compose up -d
```

### 生产环境

生产环境位于 `master/` 目录，适用于正式部署。

```bash
# 使用生产环境配置启动
docker-compose -f compose.yaml up -d
```

## 构建

项目使用 GitHub Actions 自动构建，配置文件位于 `.github/workflows/build.yml`。

## License

Apache License 2.0
