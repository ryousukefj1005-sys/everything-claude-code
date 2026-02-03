#!/bin/bash
# Claude Code 配置拉取脚本 (macOS/Linux)
# 用法：chmod +x pull-config.sh && ./pull-config.sh

echo "========================================"
echo "  Claude Code 配置拉取脚本"
echo "========================================"
echo ""

echo "[1/3] 从 GitHub 拉取最新配置..."
git pull

echo ""
echo "[2/3] 复制配置到 Claude Code..."
echo ""

# 复制 skills
echo "  - 复制 skills..."
cp -r skills/* ~/.claude/skills/ 2>/dev/null

# 复制 rules
echo "  - 复制 rules..."
cp -r rules/* ~/.claude/rules/ 2>/dev/null

# 复制 commands
echo "  - 复制 commands..."
cp -r commands/* ~/.claude/commands/ 2>/dev/null

# 复制 agents
echo "  - 复制 agents..."
cp -r agents/* ~/.claude/agents/ 2>/dev/null

echo ""
echo "[3/3] 完成！"
echo ""
echo "========================================"
echo "  ✓ 配置已同步到本地"
echo "========================================"
echo ""
echo "提示：重启 Claude Code 后生效"
echo ""
