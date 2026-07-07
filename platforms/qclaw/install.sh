#!/bin/bash
# QClaw 平台安装脚本
# 用法: bash platforms/qclaw/install.sh <project-root>
#
# 将 agent-scaffold 的 skills 安装到 QClaw 工作空间 (.agent/qclaw/skills/)

set -e

PROJECT_ROOT="${1:?Usage: install.sh <project-root>}"
SCAFFOLD_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
QCLAW_AGENT_DIR="$PROJECT_ROOT/.agent/qclaw"
QCLAW_SKILLS_DIR="$QCLAW_AGENT_DIR/skills"

echo "=== agent-scaffold: 安装到 QClaw ==="
echo "  项目根目录: $PROJECT_ROOT"
echo "  脚手架源:   $SCAFFOLD_ROOT"
echo ""

# 1. 创建目标目录
mkdir -p "$QCLAW_SKILLS_DIR"

# 2. 复制所有 skills
echo "正在复制 skills..."
for skill_dir in "$SCAFFOLD_ROOT/skills/"*/; do
  skill_name=$(basename "$skill_dir")
  if [ -d "$skill_dir" ]; then
    rm -rf "$QCLAW_SKILLS_DIR/$skill_name"
    cp -r "$skill_dir" "$QCLAW_SKILLS_DIR/$skill_name"
    echo "  ✓ $skill_name"
  fi
done

# 3. 写入 .agent-scaffold.lock
LOCK_FILE="$PROJECT_ROOT/.agent-scaffold.lock"
if [ ! -f "$LOCK_FILE" ]; then
  cp "$SCAFFOLD_ROOT/.agent-scaffold.lock" "$LOCK_FILE"
  echo "  ✓ 已创建 .agent-scaffold.lock"
fi

# 4. 确保 .agent/ 在 .gitignore 中
GITIGNORE="$PROJECT_ROOT/.gitignore"
if [ -f "$GITIGNORE" ]; then
  if ! grep -q "^\.agent/$" "$GITIGNORE"; then
    echo "" >> "$GITIGNORE"
    echo "# agent-scaffold 安装目录" >> "$GITIGNORE"
    echo ".agent/" >> "$GITIGNORE"
    echo "  ✓ 已将 .agent/ 添加到 .gitignore"
  fi
else
  echo ".agent/" > "$GITIGNORE"
  echo "  ✓ 已创建 .gitignore 并添加 .agent/"
fi

echo ""
echo "=== 安装完成 ==="
echo "  Skills 目录: $QCLAW_SKILLS_DIR"
echo "  Lock 文件:   $LOCK_FILE"
echo ""
echo "  QClaw 启动时将自动加载这些 skills。"
echo "  如果使用项目 workspace，确保 QClaw 的 workspace 指向 $PROJECT_ROOT"
