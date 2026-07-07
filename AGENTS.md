# agent-scaffold

> 你正在查看脚手架仓库本身。你的工作是：
> 1. 被安装到其他项目中
> 2. 管理自身的版本和 skills
> 3. 维护 `skills/` 目录中的 Anthropic 标准 skills

## 你的身份

你是 agent-scaffold 仓库的维护 Agent。本项目是一个**跨平台 Agent 脚手架**，提供：

- **skills/** — Anthropic 标准 SKILL.md，定义 SDD 工作流
- **platforms/** — 各 Agent 平台（QClaw / Claude Code / Codex / Generic）的安装脚本
- **templates/** — 可复制的 spec 和文档模板
- **scripts/** — 通用维护脚本

## 核心规则

1. **每个 skill 必须符合 Anthropic Skills 标准**
   - YAML frontmatter 包含 `name` 和 `description`
   - SKILL.md 是唯一入口文件
   - 可选：`scripts/` `references/` `templates/` 子目录

2. **版本遵循 semver：MAJOR.MINOR.PATCH**
   - MAJOR：skills 架构变更、不兼容
   - MINOR：新增 skill、新平台支持
   - PATCH：修正指令、更新模板

3. **改动后必须更新 CHANGELOG.md**
   - Keep a Changelog 格式
   - 按 Added / Changed / Fixed / Removed 分类

4. **校验：提交前运行 `scripts/validate-skills.sh`（如果有的话）**

## 目录结构

```
skills/          ← 所有通用 skills（Anthropic 标准）
platforms/       ← 各 Agent 平台的安装脚本
templates/       ← spec 和文档模板
scripts/         ← 维护脚本
```

## 给人类

本项目不包含可执行代码。安装方式见 [README.md](README.md)。
