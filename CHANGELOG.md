# Changelog

All notable changes to agent-scaffold will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2026-07-07

### Added
- 初始化仓库结构
- 6 个平台安装脚本：QClaw / WorkBuddy / Claude Code / Trae / Codex / Generic
- `skills/sdd-workflow/SKILL.md` — SDD 工作流总路由器（决策树 + 工作区约定）
- `skills/spec-proposal/SKILL.md` — 需求分析与 proposal 起草（5 步骤 + 约束）
- `skills/spec-design/SKILL.md` — 技术方案设计（方案比较矩阵 + 6 段模板）
- `skills/spec-tasks/SKILL.md` — 任务拆解（依赖排序 + 粒度原则 + 验收标准）
- `skills/spec-implement/SKILL.md` — 按任务实现（逐条勾选 + 自检清单 + 提交规范）
- `skills/spec-review/SKILL.md` — 验收审查（7 项清单 + 三态 verdict）
- `skills/change-proposal/SKILL.md` — 轻量变更流（适用/不适用场景 + 4 步骤）
- `skills/handoff/SKILL.md` — Agent 间交接协议（必读清单 + 交接反模式）
- `skills/changelog-update/SKILL.md` — CHANGELOG 更新（分类表 + 版本发布流程）
- `skills/scaffold-manager/SKILL.md` — 脚手架自管理（install/update/check/uninstall + 安装验证）
- `templates/` — 7 个 spec 模板（proposal/design/tasks/change-proposal/handoff/verdict/context）
- `scripts/validate-skills.sh` — SKILL.md 格式校验（10/10 通过）
