#!/bin/bash
# 通用平台安装脚本（纯文件复制，不依赖特定 Agent 工具）
# 用法: bash platforms/generic/install.sh <project-root>
#
# 将 agent-scaffold 的 skills 安装到 .agent/skills/（通用路径）

set -e

PROJECT_ROOT="${1:?Usage: install.sh <project-root>}"
SCAFFOLD_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
GENERIC_DIR="$PROJECT_ROOT/.agent"
GENERIC_SKILLS_DIR="$GENERIC_DIR/skills"

echo "=== agent-scaffold: 安装到通用路径 ==="
echo "  项目根目录: $PROJECT_ROOT"
echo "  脚手架源:   $SCAFFOLD_ROOT"
echo ""

# 1. 创建目标目录
mkdir -p "$GENERIC_SKILLS_DIR"

# 2. 复制所有 skills
echo "正在复制 skills..."
for skill_dir in "$SCAFFOLD_ROOT/skills/"*/; do
  skill_name=$(basename "$skill_dir")
  if [ -d "$skill_dir" ]; then
    rm -rf "$GENERIC_SKILLS_DIR/$skill_name"
    cp -r "$skill_dir" "$GENERIC_SKILLS_DIR/$skill_name"
    echo "  ✓ $skill_name"
  fi
done

# 3. 复制 templates
echo ""
echo "正在复制 templates..."
TEMPLATES_DIR="$GENERIC_DIR/templates"
mkdir -p "$TEMPLATES_DIR"
if [ -d "$SCAFFOLD_ROOT/templates" ]; then
  cp -r "$SCAFFOLD_ROOT/templates/"* "$TEMPLATES_DIR/"
  echo "  ✓ templates"
fi

# 4. 写入 .agent-scaffold.lock
LOCK_FILE="$PROJECT_ROOT/.agent-scaffold.lock"
if [ ! -f "$LOCK_FILE" ]; then
  cp "$SCAFFOLD_ROOT/.agent-scaffold.lock" "$LOCK_FILE"
  echo "  ✓ 已创建 .agent-scaffold.lock"
fi

# 5. 确保 .agent/ 在 .gitignore 中
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
  echo "  ✓ 已创建 .gitignore"
fi

echo ""
echo "=== 安装完成 ==="
echo "  Skills 目录:    $GENERIC_SKILLS_DIR"
echo "  Templates 目录: $TEMPLATES_DIR"
echo "  Lock 文件:      $LOCK_FILE"
echo ""
echo "  Agent 启动时读取 AGENTS.md 获取 skills 加载路径。"
