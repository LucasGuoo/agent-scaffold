#!/bin/bash
# OpenAI Codex 平台安装脚本
# 用法: bash platforms/codex/install.sh <project-root>
#
# 将 agent-scaffold 的 skills 安装到 Codex 的项目 skills 目录 (.codex/skills/)
# Codex 支持 Anthropic 标准的 SKILL.md 格式，与 Claude Code 生态互通

set -e

PROJECT_ROOT="${1:?Usage: install.sh <project-root>}"
SCAFFOLD_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
CODEX_DIR="$PROJECT_ROOT/.codex"
CODEX_SKILLS_DIR="$CODEX_DIR/skills"

echo "=== agent-scaffold: 安装到 Codex ==="
echo "  项目根目录: $PROJECT_ROOT"
echo "  脚手架源:   $SCAFFOLD_ROOT"
echo ""

# 1. 创建目标目录
mkdir -p "$CODEX_SKILLS_DIR"

# 2. 复制所有 skills
echo "正在复制 skills..."
for skill_dir in "$SCAFFOLD_ROOT/skills/"*/; do
  skill_name=$(basename "$skill_dir")
  if [ -d "$skill_dir" ]; then
    rm -rf "$CODEX_SKILLS_DIR/$skill_name"
    cp -r "$skill_dir" "$CODEX_SKILLS_DIR/$skill_name"
    echo "  ✓ $skill_name"
  fi
done

# 3. 写入 .agent-scaffold.lock
LOCK_FILE="$PROJECT_ROOT/.agent-scaffold.lock"
if [ ! -f "$LOCK_FILE" ]; then
  cp "$SCAFFOLD_ROOT/.agent-scaffold.lock" "$LOCK_FILE"
  echo "  ✓ 已创建 .agent-scaffold.lock"
fi

# 4. 确保 .codex/skills/ 在 .gitignore 中
GITIGNORE="$PROJECT_ROOT/.gitignore"
if [ -f "$GITIGNORE" ]; then
  if ! grep -q "^\.codex/skills/$" "$GITIGNORE"; then
    echo "" >> "$GITIGNORE"
    echo "# Codex agent-scaffold skills" >> "$GITIGNORE"
    echo ".codex/skills/" >> "$GITIGNORE"
    echo "  ✓ 已将 .codex/skills/ 添加到 .gitignore"
  fi
else
  echo ".codex/skills/" > "$GITIGNORE"
  echo "  ✓ 已创建 .gitignore"
fi

echo ""
echo "=== 安装完成 ==="
echo "  Skills 目录: $CODEX_SKILLS_DIR"
echo "  Lock 文件:   $LOCK_FILE"
echo ""
echo "  Codex 支持 Anthropic Skills 标准格式。"
echo "  Skills 已安装到项目级目录，Codex 启动时会自动发现并加载。"
echo "  提示：也可手动复制 skills 到 ~/.codex/skills/ 实现全局安装。"
