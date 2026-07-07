#!/bin/bash
# Claude Code 平台安装脚本
# 用法: bash platforms/claude-code/install.sh <project-root>
#
# 将 agent-scaffold 的 skills 安装到 Claude Code 的 skills 目录 (.claude/skills/)

set -e

PROJECT_ROOT="${1:?Usage: install.sh <project-root>}"
SCAFFOLD_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
CLAUDE_DIR="$PROJECT_ROOT/.claude"
CLAUDE_SKILLS_DIR="$CLAUDE_DIR/skills"

echo "=== agent-scaffold: 安装到 Claude Code ==="
echo "  项目根目录: $PROJECT_ROOT"
echo "  脚手架源:   $SCAFFOLD_ROOT"
echo ""

# 1. 创建目标目录
mkdir -p "$CLAUDE_SKILLS_DIR"

# 2. 复制所有 skills
echo "正在复制 skills..."
for skill_dir in "$SCAFFOLD_ROOT/skills/"*/; do
  skill_name=$(basename "$skill_dir")
  if [ -d "$skill_dir" ]; then
    rm -rf "$CLAUDE_SKILLS_DIR/$skill_name"
    cp -r "$skill_dir" "$CLAUDE_SKILLS_DIR/$skill_name"
    echo "  ✓ $skill_name"
  fi
done

# 3. 写入 .agent-scaffold.lock
LOCK_FILE="$PROJECT_ROOT/.agent-scaffold.lock"
if [ ! -f "$LOCK_FILE" ]; then
  cp "$SCAFFOLD_ROOT/.agent-scaffold.lock" "$LOCK_FILE"
  echo "  ✓ 已创建 .agent-scaffold.lock"
fi

# 4. 确保 .claude/skills/ 在 .gitignore 中
GITIGNORE="$PROJECT_ROOT/.gitignore"
if [ -f "$GITIGNORE" ]; then
  if ! grep -q "^\.claude/skills/$" "$GITIGNORE"; then
    echo "" >> "$GITIGNORE"
    echo "# Claude Code agent-scaffold skills" >> "$GITIGNORE"
    echo ".claude/skills/" >> "$GITIGNORE"
    echo "  ✓ 已将 .claude/skills/ 添加到 .gitignore"
  fi
else
  echo ".claude/skills/" > "$GITIGNORE"
  echo "  ✓ 已创建 .gitignore"
fi

echo ""
echo "=== 安装完成 ==="
echo "  Skills 目录: $CLAUDE_SKILLS_DIR"
echo "  Lock 文件:   $LOCK_FILE"
echo ""
echo "  Claude Code 将在启动时自动加载这些 skills。"
