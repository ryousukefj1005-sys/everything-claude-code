# Everything-Claude 使用教程

> **Everything Claude Code** - 来自 Anthropic 黑客马拉松获胜者的完整 Claude Code 配置集合
>
> 版本: 1.2.0 | 作者: Affaan Mustafa

---

## 目录

- [快速开始](#快速开始)
- [斜杠命令](#斜杠命令)
- [代理系统](#代理系统)
- [技能库](#技能库)
- [规则系统](#规则系统)
- [钩子自动化](#钩子自动化)
- [MCP 服务器](#mcp-服务器)
- [故障排除](#故障排除)

---

## 快速开始

### 安装状态检查

```bash
# 检查已安装的命令
ls ~/.claude/commands/

# 检查已安装的代理
ls ~/.claude/agents/

# 检查已安装的技能
ls ~/.claude/skills/

# 检查已安装的规则
ls ~/.claude/rules/
```

### 立即体验

```bash
# 测试驱动开发
/tdd

# 代码审查
/code-review

# 实现规划
/plan

# 包管理器设置
/setup-pm
```

---

## 斜杠命令

### 开发工作流

#### `/tdd` - 测试驱动开发

强制执行 TDD 工作流：先写测试，再实现代码。

```
使用场景：
- 编写新功能时
- 修复 bug 时
- 重构代码时

工作流程：
1. 定义接口
2. 编写失败的测试 (RED)
3. 实现最少代码 (GREEN)
4. 重构 (IMPROVE)
5. 确保 80%+ 覆盖率
```

#### `/plan` - 实现规划

在开始编码前创建详细的实现计划。

```
使用场景：
- 复杂功能实现（≥3 文件）
- 架构决策需要讨论时
- 多种实现方案时

输出：
- 需求重述
- 风险评估
- 分步实施计划
- 关键文件列表
```

#### `/code-review` - 代码审查

对当前代码进行质量和安全审查。

```
检查项目：
- 代码质量和可维护性
- 安全漏洞
- 性能问题
- 最佳实践遵循
```

#### `/build-fix` - 修复构建错误

自动分析和修复构建/编译错误。

```
支持：
- npm/yarn/pnpm build
- TypeScript 类型错误
- ESLint 错误
- 其他构建工具错误
```

#### `/refactor-clean` - 清理死代码

识别并移除未使用的代码和导入。

```
清理内容：
- 未使用的导入
- 未声明的变量
- 死代码分支
- 重复代码
```

### 测试相关

#### `/e2e` - 端到端测试

使用 Playwright 生成和运行 E2E 测试。

```
功能：
- 创建测试旅程
- 运行测试
- 捕获截图/视频/trace
- 上传测试产物
```

#### `/test-coverage` - 测试覆盖率

检查和显示测试覆盖率报告。

```
支持工具：
- Jest
- Vitest
- Pytest
- Go test
```

### 持续学习

#### `/learn` - 提取可重用模式

从当前会话中提取模式并保存为技能。

```
使用方式：
/learn                    # 分析当前会话
/learn --instincts        # 还生成直觉模式
```

#### `/skill-create` - 从 Git 历史生成技能

分析本地 git 历史并生成 SKILL.md 文件。

```
功能：
- 分析提交历史
- 提取编码模式
- 生成技能文档
```

#### `/evolve` - 演化直觉为技能

将相关的直觉聚类为技能、命令或代理。

```
用途：
- 整理已学习的模式
- 创建可重用组件
- 分享知识
```

#### `/instinct-status` - 显示学习状态

显示所有已学习的直觉及其置信度水平。

#### `/instinct-import` - 导入直觉

从文件或队友处导入直觉。

```
/instinct-import instincts.json
```

#### `/instinct-export` - 导出直觉

导出你的直觉以供分享。

### 会话管理

#### `/checkpoint` - 保存验证状态

保存当前会话状态以便后续恢复。

#### `/eval` - 运行评估

执行正式的评估框架。

#### `/verify` - 验证循环

持续验证代码质量和功能正确性。

### Go 语言专用

#### `/go-test` - Go TDD 工作流

强制 Go 的 TDD 工作流：先写表驱动测试。

```
要求：
- 表驱动测试
- 80%+ 覆盖率
- 使用 go test -cover
```

#### `/go-review` - Go 代码审查

Go 代码的全面审查。

```
检查：
- 惯用模式
- 并发安全
- 错误处理
- 安全性
```

#### `/go-build` - 修复 Go 构建错误

修复 Go 构建错误、go vet 警告和 linter 问题。

### 其他

#### `/setup-pm` - 配置包管理器

设置首选包管理器（npm/pnpm/yarn/bun）。

```
/setup-pm npm
/setup-pm pnpm
```

#### `/orchestrate` - 编排命令

协调多个代理和任务。

#### `/update-docs` - 更新文档

自动更新项目文档。

#### `/update-codemaps` - 更新代码地图

刷新代码地图以反映最新更改。

---

## 代理系统

### 使用方式

```bash
# 委托任务给代理
@planner 设计用户认证系统
@code-reviewer 检查 src/auth.ts
@architect 规划微服务架构
@security-reviewer 审查支付流程
```

### 可用代理

#### `@planner` - 规划师

功能实现规划代理。

```
职责：
- 分析需求
- 创建实施计划
- 识别风险
- 定义里程碑

使用场景：
- 新功能开发
- 大型重构
- 架构变更
```

#### `@architect` - 架构师

系统设计决策代理。

```
职责：
- 技术栈选择
- 架构设计
- 数据流设计
- 接口设计

使用场景：
- 新项目启动
- 架构重构
- 技术选型
```

#### `@code-reviewer` - 代码审查员

代码质量和安全审查。

```
检查内容：
- 代码质量
- 可维护性
- 安全漏洞
- 性能问题
- 最佳实践
```

#### `@security-reviewer` - 安全审查员

漏洞分析和安全审查。

```
检查项目：
- OWASP Top 10
- 认证/授权
- 数据加密
- 输入验证
- 输出编码
```

#### `@tdd-guide` - TDD 指导

测试驱动开发指导。

```
职责：
- TDD 工作流指导
- 测试设计
- 覆盖率要求
- 重构建议
```

#### `@build-error-resolver` - 构建错误解决

修复构建和编译错误。

```
支持：
- TypeScript
- JavaScript
- 构建工具错误
```

#### `@e2e-runner` - E2E 测试运行

Playwright E2E 测试生成和执行。

```
功能：
- 创建测试用例
- 运行测试
- 报告结果
- 调试支持
```

#### `@refactor-cleaner` - 重构清理

死代码清理和重构。

```
清理：
- 未使用代码
- 重复代码
- 复杂逻辑简化
```

#### `@doc-updater` - 文档更新

文档同步和更新。

```
功能：
- 同步代码和文档
- 生成 API 文档
- 更新 README
```

#### `@go-reviewer` - Go 代码审查

Go 代码专项审查。

```
检查：
- Go 惯用语法
- 并发模式
- 错误处理
- 性能优化
```

#### `@go-build-resolver` - Go 构建解决

Go 构建错误修复。

```
解决：
- go build 错误
- go vet 警告
- 静态检查问题
```

#### `@database-reviewer` - 数据库审查

数据库查询和设计审查。

```
检查：
- SQL 优化
- 索引设计
- 查询性能
- 数据一致性
```

#### `@python-reviewer` - Python 代码审查

Python 代码专项审查。

```
检查：
- PEP 8 合规
- 类型提示
- Pythonic 惯用法
- 安全性
```

---

## 技能库

### 工作流技能

#### `tdd-workflow`

测试驱动开发完整工作流。

```
使用：
/skill tdd-workflow

包含：
- TDD 方法论
- 测试设计模式
- 覆盖率要求
- 重构指导
```

#### `continuous-learning`

从会话中自动提取可重用模式。

```
功能：
- 自动观察会话
- 识别模式
- 保存为技能
- 跨会话复用
```

#### `continuous-learning-v2`

基于直觉的学习系统。

```
功能：
- 置信度评分
- 原子直觉提取
- 技能演化
- 模式聚类
```

#### `strategic-compact`

战略性上下文压缩建议。

```
功能：
- 在逻辑间隔建议压缩
- 保留任务阶段上下文
- 避免自动压缩丢失信息
```

### 编码标准

#### `coding-standards`

通用编码标准和最佳实践。

```
覆盖：
- TypeScript/JavaScript
- React
- Node.js
- 代码风格
- 命名约定
```

### 前端模式

#### `frontend-patterns`

React、Next.js 前端模式。

```
内容：
- 组件设计
- 状态管理
- 性能优化
- UI 最佳实践
```

### 后端模式

#### `backend-patterns`

Node.js、Express 后端模式。

```
内容：
- API 设计
- 数据库优化
- 缓存策略
- 服务端最佳实践
```

### 框架专用

#### `springboot-patterns` / `django-patterns` / `golang-patterns`

各框架的专用模式和最佳实践。

### 测试

#### `verification-loop` / `eval-harness`

验证循环和评估框架。

```
功能：
- 持续验证
- 检查点管理
- 评分指标
- pass@k 度量
```

### 安全

#### `security-review`

安全审查检查清单。

```
使用场景：
- 添加认证时
- 处理用户输入时
- 处理密钥时
- 实现 API 端点时
- 实现支付/敏感功能时
```

---

## 规则系统

规则是 Claude 始终遵循的全局指南。

### 已安装规则

#### `rules/security.md`

强制性安全检查。

```
内容：
- 禁止硬编码密钥
- 输入验证要求
- 输出编码
- 认证/授权模式
- 数据加密
```

#### `rules/coding-style.md`

编码风格规范。

```
内容：
- 不可变性原则
- 文件组织
- 命名约定
- 代码复杂度限制
```

#### `rules/testing.md`

测试规范。

```
要求：
- TDD 方法论
- 80%+ 覆盖率
- 单元/集成/E2E 测试
- 测试命名约定
```

#### `rules/git-workflow.md`

Git 工作流。

```
内容：
- 提交格式
- PR 流程
- 分支策略
- 代码审查要求
```

#### `rules/agents.md`

代理使用指南。

```
内容：
- 何时委托给子代理
- 上下文管理
- 代理选择
```

#### `rules/performance.md`

性能优化。

```
内容：
- 模型选择
- 上下文管理
- Token 优化
```

#### `rules/patterns.md`

设计模式。

```
内容：
- 常用设计模式
- 反模式识别
- 重构建议
```

#### `rules/hooks.md`

钩子使用说明。

```
内容：
- 钩子类型
- 触发时机
- 自定义钩子
```

---

## 钩子自动化

### 已配置钩子

#### SessionStart

会话开始时自动执行：

```
- 加载之前的上下文
- 检测包管理器
```

#### SessionEnd

会话结束时自动执行：

```
- 保存会话状态
- 提取可重用模式
```

#### PreCompact

上下文压缩前执行：

```
- 保存当前状态
- 准备压缩
```

#### PreToolUse / PostToolUse

工具执行前后钩子：

```
PreToolUse:
- 阻止 tmux 外的 dev server
- 提醒使用 tmux 运行长命令
- Git push 前提醒
- 阻止创建不必要的 .md 文件

PostToolUse:
- PR 创建后记录 URL
- 构建后异步分析
- 自动格式化 JS/TS
- TypeScript 类型检查
- console.log 警告
```

#### Stop

每次响应后执行：

```
- 检查修改文件中的 console.log
```

---

## MCP 服务器

### 可用 MCP 配置

仓库提供以下 MCP 服务器配置（在 `mcp-configs/mcp-servers.json`）：

| 服务器 | 用途 | 需要配置 |
|--------|------|---------|
| github | GitHub PR/Issue 操作 | PAT Token |
| firecrawl | 网页抓取和爬取 | API Key |
| supabase | Supabase 数据库操作 | Project Ref |
| memory | 跨会话持久化内存 | - |
| sequential-thinking | 链式思考推理 | - |
| vercel | Vercel 部署和项目 | - |
| railway | Railway 部署 | - |
| cloudflare-* | Cloudflare 各种服务 | - |
| clickhouse | ClickHouse 分析查询 | - |
| context7 | 实时文档查找 | - |
| magic | Magic UI 组件 | - |
| filesystem | 文件系统操作 | 路径配置 |

### 添加 MCP 配置

1. 打开 `mcp-configs/mcp-servers.json`
2. 将需要的服务器配置复制到 `~/.claude.json`
3. 替换 `YOUR_*_HERE` 占位符
4. 重启 Claude Code

### 重要提醒

**保持启用 MCP < 10 个** 以避免上下文窗口缩小。

在项目配置中使用 `disabledMcpServers` 禁用未使用的：

```json
{
  "disabledMcpServers": ["firecrawl", "supabase"]
}
```

---

## 故障排除

### 问题 1: 命令不工作

**症状**: 输入 `/tdd` 等命令没有反应

**解决**:
```bash
# 检查命令文件是否存在
ls ~/.claude/commands/

# 重启 Claude Code
```

### 问题 2: 代理不响应

**症状**: `@planner` 等代理没有效果

**解决**:
```bash
# 检查代理文件是否存在
ls ~/.claude/agents/

# 确认文件格式正确（包含 --- 元数据）
```

### 问题 3: Hooks 不工作

**症状**: 自动化钩子没有执行

**解决**:
```bash
# 检查 settings.json 中的 hooks 配置
# 确认 CLAUDE_PLUGIN_ROOT 环境变量正确
# 测试脚本可执行性：
node "D:\AI Project\everything-claude-code\scripts\hooks\session-start.js"
```

### 问题 4: 上下文窗口缩小

**症状**: 上下文突然变小，经常被压缩

**解决**:
```bash
# 检查已启用的 MCP 数量
# 禁用不需要的 MCP

# 在项目 .claude/config.json 中添加：
{
  "disabledMcpServers": ["server1", "server2"]
}
```

### 问题 5: 规则不生效

**症状**: 编码风格等规则没有被执行

**解决**:
```bash
# 确认规则在用户级目录
ls ~/.claude/rules/

# 如果在项目级 .claude/rules/，只对该项目生效
```

### 问题 6: 技能找不到

**症状**: `/skill tdd-workflow` 报错

**解决**:
```bash
# 检查技能目录
ls ~/.claude/skills/

# 确认技能目录中有 SKILL.md 文件
ls ~/.claude/skills/tdd-workflow/
```

---

## 高级用法

### 创建自定义技能

```bash
# 1. 创建技能目录
mkdir ~/.claude/skills/my-skill

# 2. 创建 SKILL.md
cat > ~/.claude/skills/my-skill/SKILL.md << 'EOF'
# My Custom Skill

## 何时使用
- 描述使用场景

## 工作流程
1. 步骤一
2. 步骤二
3. 步骤三

## 注意事项
- 重要提示
EOF

# 3. 使用技能
/skill my-skill
```

### 创建自定义命令

```bash
# 1. 创建命令文件
cat > ~/.claude/commands/my-command.md << 'EOF'
---
description: 我的自定义命令
---

# 我的命令

执行以下操作：
1. 操作一
2. 操作二
3. 操作三
EOF

# 2. 使用命令
/my-command
```

### 创建自定义代理

```bash
# 1. 创建代理文件
cat > ~/.claude/agents/my-agent.md << 'EOF'
---
name: my-agent
description: 我的专用代理
tools: ["Read", "Write", "Bash"]
model: sonnet
---

你是一个专用代理，负责...
EOF

# 2. 使用代理
@my-agent 执行任务
```

---

## 配置文件位置

| 文件 | 路径 |
|------|------|
| 仓库根目录 | `D:\AI Project\everything-claude-code` |
| 用户规则 | `C:\Users\Ryousuke\.claude\rules\` |
| 用户代理 | `C:\Users\Ryousuke\.claude\agents\` |
| 用户命令 | `C:\Users\Ryousuke\.claude\commands\` |
| 用户技能 | `C:\Users\Ryousuke\.claude\skills\` |
| Claude 配置 | `C:\Users\Ryousuke\.claude.json` |
| Settings | `C:\Users\Ryousuke\.claude\settings.json` |
| 市场配置 | `C:\Users\Ryousuke\.claude\plugins\known_marketplaces.json` |

---

## 更新和维护

### 更新到最新版本

```bash
cd "D:\AI Project\everything-claude-code"
git pull origin main

# 重新复制文件（如有新增）
cp agents/*.md ~/.claude/agents/
cp commands/*.md ~/.claude/commands/
cp -r skills/* ~/.claude/skills/
```

### 贡献

欢迎贡献！参见 [CONTRIBUTING.md](https://github.com/affaan-m/everything-claude-code/blob/main/CONTRIBUTING.md)

---

## 参考资源

- [精简指南](https://x.com/affaanmustafa/status/2012378465664745795)
- [详细指南](https://x.com/affaanmustafa/status/2014040193557471352)
- [GitHub 仓库](https://github.com/affaan-m/everything-claude-code)
- [作者 Twitter](https://x.com/affaanmustafa)

---

**如果这个工具对你有帮助，请给仓库一个 Star！**
