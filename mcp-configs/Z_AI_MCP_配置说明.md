# Z.AI MCP 服务器配置说明

本文档说明如何配置和使用 Z.AI (智谱AI) 提供的 4 个 MCP 服务器。

---

## 前置条件

1. **获取 Z.AI API Key**
   - 访问: https://open.bigmodel.cn/
   - 注册/登录账号
   - 在控制台获取 API Key

2. **确认环境**
   - Claude Code 已安装
   - Node.js >= v22.0.0 (用于 vision-mcp-server)

---

## MCP 服务器列表

| 服务器名称 | 类型 | 主要工具 |
|-----------|------|---------|
| **zai-mcp-server** | stdio | 8个视觉分析工具 |
| **zai-brave-search** | http | 联网搜索 |
| **zai-web-reader** | http | 网页读取 |
| **zai-zread** | http | GitHub文档搜索 |

---

## 配置方法

### 方法 1: 使用命令行 (推荐)

```bash
# Vision MCP Server
claude mcp add -s user zai-mcp-server --env Z_AI_API_KEY=your_api_key Z_AI_MODE=ZAI -- npx -y "@z_ai/mcp-server"

# Web Reader MCP Server
claude mcp add -s user -t http zai-web-reader https://api.z.ai/api/mcp/web_reader/mcp --header "Authorization: Bearer your_api_key"

# Zread MCP Server
claude mcp add -s user -t http zai-zread https://api.z.ai/api/mcp/zread/mcp --header "Authorization: Bearer your_api_key"
```

### 方法 2: 手动编辑配置文件

编辑 `~/.claude.json` (Windows: `%USERPROFILE%\.claude.json`)，添加以下内容：

```json
{
  "mcpServers": {
    "zai-mcp-server": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@z_ai/mcp-server"],
      "env": {
        "Z_AI_API_KEY": "your_api_key",
        "Z_AI_MODE": "ZAI"
      }
    },
    "zai-brave-search": {
      "type": "http",
      "url": "https://api.z.ai/api/mcp/search/mcp",
      "headers": {
        "Authorization": "Bearer your_api_key"
      }
    },
    "zai-web-reader": {
      "type": "streamable-http",
      "url": "https://api.z.ai/api/mcp/web_reader/mcp",
      "headers": {
        "Authorization": "Bearer your_api_key"
      }
    },
    "zai-zread": {
      "type": "streamable-http",
      "url": "https://api.z.ai/api/mcp/zread/mcp",
      "headers": {
        "Authorization": "Bearer your_api_key"
      }
    }
  }
}
```

---

## 工具详解

### zai-mcp-server (Vision)

**包名**: `@z_ai/mcp-server`

**工具列表**:
1. `ui_to_artifact` - UI截图转代码/提示词/规格
2. `extract_text_from_screenshot` - OCR文字提取
3. `diagnose_error_screenshot` - 错误截图诊断
4. `understand_technical_diagram` - 技术图表理解
5. `analyze_data_visualization` - 数据图表分析
6. `ui_diff_check` - UI对比检查
7. `image_analysis` - 通用图片理解
8. `video_analysis` - 视频内容分析

**使用示例**:
```
"帮我分析这个截图: screenshot.png"
"描述这张图片的内容"
"提取截图中的文字"
```

### zai-brave-search (Search)

**URL**: `https://api.z.ai/api/mcp/search/mcp`

**功能**: 联网搜索，基于 Brave Search API

**使用示例**:
```
"搜索最新的 Python 3.13 新特性"
"查询 Claude Code 的使用教程"
```

### zai-web-reader (Reader)

**URL**: `https://api.z.ai/api/mcp/web_reader/mcp`

**功能**: 网页内容读取，返回网页标题、主要内容、元数据、链接列表等

**使用示例**:
```
"读取 https://example.com 的内容"
"获取这个页面的主要信息"
```

### zai-zread (Zread)

**URL**: `https://api.z.ai/api/mcp/zread/mcp`

**工具列表**:
1. `search_doc` - GitHub文档搜索
2. `get_repo_structure` - 仓库目录结构
3. `read_file` - 读取文件内容

**使用示例**:
```
"搜索 vitejs/vite 仓库的 dev 相关文档"
"获取 anthropic/claude-code 的项目结构"
"读取某个文件的内容"
```

---

## 故障排除

### MCP 服务器无响应

```bash
# 检查 MCP 服务器列表
claude mcp list

# 移除有问题的服务器
claude mcp remove zai-mcp-server

# 重新安装
claude mcp add -s user zai-mcp-server --env Z_AI_API_KEY=your_api_key Z_AI_MODE=ZAI -- npx -y "@z_ai/mcp-server"
```

### API Key 错误

确认：
1. API Key 格式正确
2. 账户有足够配额
3. 网络连接正常

### Vision MCP 安装失败

```bash
# 测试本地安装
npx -y @z_ai/mcp-server

# 检查 Node.js 版本
node --version  # 需要 >= v22.0.0
```

---

## 资源链接

- [Z.AI 开发者文档](https://docs.z.ai/devpack/mcp)
- [Vision MCP Server](https://docs.z.ai/devpack/mcp/vision-mcp-server)
- [Web Search MCP Server](https://docs.z.ai/devpack/mcp/search-mcp-server)
- [Web Reader MCP Server](https://docs.z.ai/devpack/mcp/reader-mcp-server)
- [Zread MCP Server](https://docs.z.ai/devpack/mcp/zread-mcp-server)
- [Z.AI 控制台](https://open.bigmodel.cn/)

---

**最后更新**: 2026-02-05
