# 项目初始化技能

## 描述

为新项目创建完整的 Dev Container + Git 配置。包括 .devcontainer、.gitignore、requirements.txt 等文件。

## 使用场景

- 创建新项目时
- 将现有项目迁移到 Dev Container
- 统一项目结构

## 执行步骤

1. 询问项目类型（Python/Node.js/Go）
2. 创建 .devcontainer 目录和配置文件
3. 创建 .gitignore 文件
4. 创建 requirements.txt 或 package.json
5. 初始化 Git 仓库
6. 创建首次提交

## 参数

- `type` (必需): 项目类型（python/nodejs/go）
- `name` (可选): 项目名称

## 示例

```
/project-init python
/project-init python "我的量化项目"
```

## 生成的文件结构

```
project-name/
├── .devcontainer/
│   └── devcontainer.json
├── .gitignore
├── requirements.txt  (Python 项目)
├── README.md
└── src/
```
