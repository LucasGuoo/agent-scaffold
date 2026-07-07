#!/bin/bash
# Trae IDE 平台安装脚本
# 用法: bash platforms/trae/install.sh <project-root>
#
# 将 agent-scaffold 的 skills 安装到 Trae IDE 的项目 skills 目录 (.trae/skills/)
# Trae 使用 Anthropic 标准 SKILL.md 格式，支持 .trae/skills/ 项目级加载

set -e

PROJECT_ROOT="${1:?Usage: install.sh <project-root>}"
SCAFFOLD_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
TRAE_DIR="$PROJECT_ROOT/.trae"
TRAE_SKILLS_DIR="$TRAE_DIR/skills"

echo "=== agent-scaffold: 安装到 Trae IDE ==="
echo "  项目根目录: $PROJECT_ROOT"
echo "  脚手架源:   $SCAFFOLD_ROOT"
echo ""

# 1. 创建目标目录
mkdir -p "$TRAE_SKILLS_DIR"

# 2. 复制所有 skills
echo "正在复制 skills..."
for skill_dir in "$SCAFFOLD_ROOT/skills/"*/; do
  skill_name=$(basename "$skill_dir")
  if [ -d "$skill_dir" ]; then
    rm -rf "$TRAE_SKILLS_DIR/$skill_name"
    cp -r "$skill_dir" "$TRAE_SKILLS_DIR/$skill_name"
    echo "  ✓ $skill_name"
  fi
done

# 3. 写入 .agent-scaffold.lock
LOCK_FILE="$PROJECT_ROOT/.agent-scaffold.lock"
if [ ! -f "$LOCK_FILE" ]; then
  cp "$SCAFFOLD_ROOT/.agent-scaffold.lock" "$LOCK_FILE"
  echo "  ✓ 已创建 .agent-scaffold.lock"
fi

# 4. 确保 .trae/skills/ 在 .gitignore 中
GITIGNORE="$PROJECT_ROOT/.gitignore"
if [ -f "$GITIGNORE" ]; then
  if ! grep -q "^\.trae/skills/$" "$GITIGNORE"; then
    echo "" >> "$GITIGNORE"
    echo "# Trae IDE agent-scaffold skills" >> "$GITIGNORE"
    echo ".trae/skills/" >> "$GITIGNORE"
    echo "  ✓ 已将 .trae/skills/ 添加到 .gitignore"
  fi
else
  echo ".trae/skills/" > "$GITIGNORE"
  echo "  ✓ 已创建 .gitignore"
fi

echo ""
echo "=== 安装完成 ==="
echo "  Skills 目录: $TRAE_SKILLS_DIR"
echo "  Lock 文件:   $LOCK_FILE"
echo ""
echo "  Trae IDE 将在启动时自动加载 .trae/skills/ 中的 Anthropic 标准 skills。"
echo "  如需全局安装，手动复制 skills 到 ~/.trae/skills/"
