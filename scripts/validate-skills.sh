#!/bin/bash
# 校验所有 skills/SKILL.md 格式
# 检查 YAML frontmatter 的 name 和 description 字段

set -e

SCAFFOLD_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SKILLS_DIR="$SCAFFOLD_ROOT/skills"

echo "=== 校验 Agent Skills 格式 ==="
echo ""

ERRORS=0
SKILL_COUNT=0

for skill_dir in "$SKILLS_DIR/"*/; do
  skill_name=$(basename "$skill_dir")
  SKILL_MD="$skill_dir/SKILL.md"

  if [ ! -f "$SKILL_MD" ]; then
    echo "❌ skills/$skill_name/ 缺少 SKILL.md"
    ERRORS=$((ERRORS + 1))
    continue
  fi

  SKILL_COUNT=$((SKILL_COUNT + 1))

  # 检查 YAML frontmatter 开始
  if ! head -1 "$SKILL_MD" | grep -q "^---$"; then
    echo "❌ skills/$skill_name/SKILL.md 缺少 YAML frontmatter (第一行不是 ---)"
    ERRORS=$((ERRORS + 1))
    continue
  fi

  # 提取 YAML frontmatter 内容
  FRONTMATTER=$(sed -n '/^---$/,/^---$/p' "$SKILL_MD" | sed '1d;$d')

  # 检查 name
  if ! echo "$FRONTMATTER" | grep -q "^name:"; then
    echo "❌ skills/$skill_name/SKILL.md 缺少 name 字段"
    ERRORS=$((ERRORS + 1))
  fi

  # 检查 description
  if ! echo "$FRONTMATTER" | grep -q "^description:"; then
    echo "❌ skills/$skill_name/SKILL.md 缺少 description 字段"
    ERRORS=$((ERRORS + 1))
  fi

  echo "✅ skills/$skill_name — 格式校验通过"
done

echo ""
echo "=== 校验结果 ==="
echo "  总计: $SKILL_COUNT 个 skills"
echo "  通过: $((SKILL_COUNT - ERRORS)) 个"
echo "  错误: $ERRORS 个"

if [ $ERRORS -gt 0 ]; then
  echo ""
  echo "❌ 存在格式错误，请修复后重新提交"
  exit 1
fi

echo "✅ 所有 skills 格式校验通过"
