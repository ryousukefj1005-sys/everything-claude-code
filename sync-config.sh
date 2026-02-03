#!/bin/bash
# Claude Code 配置同步脚本 (macOS/Linux)
# 用法：chmod +x sync-config.sh && ./sync-config.sh

echo "========================================"
echo "  Claude Code 配置同步脚本"
echo "========================================"
echo ""

# 检查当前目录
if [ ! -d ".git" ]; then
    echo "[错误] 当前目录不是 Git 仓库"
    echo "请在 everything-claude-code 目录下运行此脚本"
    exit 1
fi

echo "[1/4] 复制你的配置到项目..."
echo ""

# 复制 skills
echo "  - 复制 skills..."
cp -r ~/.claude/skills/* skills/ 2>/dev/null

# 复制 rules
echo "  - 复制 rules..."
cp -r ~/.claude/rules/* rules/ 2>/dev/null

# 复制 commands
echo "  - 复制 commands..."
cp -r ~/.claude/commands/* commands/ 2>/dev/null

# 复制 agents
echo "  - 复制 agents..."
cp -r ~/.claude/agents/* agents/ 2>/dev/null

echo ""
echo "[2/4] 检查 Git 状态..."
git status --short

echo ""
echo "[3/4] 提交更改..."
git add .
git commit -m "sync: 配置自动同步 $(date '+%Y-%m-%d %H:%M:%S')" 2>/dev/null
if [ $? -eq 0 ]; then
    echo "  ✓ 已提交"
else
    echo "  ⚠ 没有新的更改"
fi

echo ""
echo "[4/4] 推送到 GitHub..."
git push

if [ $? -eq 0 ]; then
    echo ""
    echo "========================================"
    echo "  ✓ 配置同步完成！"
    echo "========================================"
else
    echo ""
    echo "========================================"
    echo "  ⚠ 推送失败，请检查网络连接"
    echo "========================================"
fi

echo ""
