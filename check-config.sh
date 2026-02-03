#!/bin/bash
# Claude Code 配置检查脚本 (Mac/Linux)
# 每周运行一次，检查配置健康状态

echo ""
echo "========================================"
echo "  Claude Code 配置健康检查"
echo "========================================"
echo ""

score=0
total=10

# [1] 检查配置目录
echo "[1/10] 检查配置目录..."
if [ -d "$HOME/.claude" ]; then
    echo "  ✓ 配置目录存在"
    ((score++))
else
    echo "  ✗ 配置目录不存在"
fi

# [2] 检查配置文件
echo "[2/10] 检查配置文件..."
if [ -f "$HOME/.claude/settings.json" ]; then
    echo "  ✓ settings.json 存在"
    ((score++))
else
    echo "  ✗ settings.json 缺失"
fi

# [3] 检查技能目录
echo "[3/10] 检查技能目录..."
if [ -d "$HOME/.claude/skills" ]; then
    echo "  ✓ skills 目录存在"
    ((score++))
else
    echo "  ✗ skills 目录缺失"
fi

# [4] 统计技能数量
echo "[4/10] 统计技能数量..."
skill_count=$(find "$HOME/.claude/skills" -maxdepth 1 -type d | wc -l)
echo "  发现 $skill_count 个技能"
if [ $skill_count -gt 0 ]; then
    ((score++))
fi

# [5] 检查规则目录
echo "[5/10] 检查规则目录..."
if [ -d "$HOME/.claude/rules" ]; then
    echo "  ✓ rules 目录存在"
    ((score++))
else
    echo "  ✗ rules 目录缺失"
fi

# [6] 统计规则数量
echo "[6/10] 统计规则数量..."
rule_count=$(find "$HOME/.claude/rules" -name "*.md" | wc -l)
echo "  发现 $rule_count 个规则"
if [ $rule_count -gt 0 ]; then
    ((score++))
fi

# [7] 检查 Git 仓库
echo "[7/10] 检查 Git 仓库..."
if [ -d "$HOME/Documents/AI-Project/everything-claude-code/.git" ]; then
    echo "  ✓ Git 仓库存在"
    ((score++))
else
    echo "  ✗ Git 仓库缺失"
fi

# [8] 检查远程连接
echo "[8/10] 检查远程连接..."
cd ~/Documents/AI-Project/everything-claude-code 2>/dev/null
if [ $? -eq 0 ]; then
    remote_url=$(git remote -v | grep origin | head -1 | awk '{print $2}')
    echo "  ✓ 远程仓库：$remote_url"
    ((score++))
else
    echo "  ✗ 无法访问仓库目录"
fi

# [9] 检查同步状态
echo "[9/10] 检查同步状态..."
cd ~/Documents/AI-Project/everything-claude-code 2>/dev/null
if [ $? -eq 0 ]; then
    changes=$(git status --short | wc -l)
    if [ $changes -eq 0 ]; then
        echo "  ✓ 工作区干净"
        ((score++))
    else
        echo "  ⚠ 有 $changes 个未提交的改动"
    fi
fi

# [10] 检查 SSH 连接
echo "[10/10] 检查 GitHub SSH 连接..."
ssh -T git@github.com 2>&1 | grep -q "successfully authenticated"
if [ $? -eq 0 ]; then
    echo "  ✓ SSH 连接正常"
    ((score++))
else
    echo "  ✗ SSH 连接失败"
fi

# 计算健康分数
echo ""
echo "========================================"
echo "  健康检查结果"
echo "========================================"
echo "得分：$score / $total"
percent=$((score * 10))
echo "健康度：$percent%"

if [ $score -ge 9 ]; then
    echo "状态：✓ 优秀"
    echo ""
    echo "你的配置运行良好！"
elif [ $score -ge 7 ]; then
    echo "状态：⚠ 良好"
    echo ""
    echo "建议检查失败的项。"
else
    echo "状态：✗ 需要修复"
    echo ""
    echo "请按照上面的问题逐项修复。"
fi

echo ""
echo "========================================"
echo "  详细信息"
echo "========================================"
echo ""
echo "配置目录位置："
echo "  $HOME/.claude"
echo ""
echo "Git 仓库位置："
echo "  $HOME/Documents/AI-Project/everything-claude-code"
echo ""
echo "远程仓库："
cd ~/Documents/AI-Project/everything-claude-code 2>/dev/null
git remote -v
echo ""
