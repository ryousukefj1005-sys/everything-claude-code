# 通宵模式 Skill

启动 Claude Code 无人值守长时间运行模式

## 触发关键词

- "通宵模式"
- "启动通宵模式"
- "通宵挂机"
- "启动挂机模式"
- "/通宵模式"

## 描述

启动 Python 看门狗脚本，监控 Claude Code 会话并自动执行上下文压缩，实现无人值守长时间运行。

## 执行步骤

1. 告知用户启动通宵模式

2. 使用 Bash 工具执行启动脚本：
   ```bash
   C:\Users\Ryousuke\.claude\通宵模式.bat
   ```

3. 告知用户如何使用：
   - 等待 Claude 启动并出现 `>` 提示符
   - 粘贴启动提示词（ kickoff_prompt.txt）
   - 将 `[TASK_PLACEHOLDER]` 替换为实际任务

4. 提示用户停止方法：
   - 按 `Ctrl+C` 停止
   - 或使用 `停止通宵模式` 命令

## 相关文件

- 启动脚本: `C:\Users\Ryousuke\.claude\通宵模式.bat`
- 启动提示词: `C:\Users\Ryousuke\.claude\templates\kickoff_prompt.txt`
- 使用文档: `C:\Users\Ryousuke\.claude\通宵挂机使用指南.md`
