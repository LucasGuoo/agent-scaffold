---
name: sdd-workflow
description: >
  SDD 工作流总路由器。任何涉及代码变更的请求必须先经过此判断。
  包含完整决策树、CHANGELOG 规范、spec 生命周期管理。
  触发：编码、新功能、bugfix、重构、配置变更、任何涉及文件的改动。
version: 0.2.0
---

# SDD Workflow — 总路由器

## 核心原则

**AGENTS.md 是第一入口，本 skill 是详细参考。**

AGENTS.md 中已写入决策树的精简版。Agent 启动时自动读取 AGENTS.md，
按其中规则判断当前请求该走什么流程。当流程深入到具体阶段时，
按需加载对应 sub-skill（spec-proposal / spec-design / spec-tasks / spec-implement / spec-review）。

## 决策树（精简版，写入 AGENTS.md）

```
改动来了 →
  纯文档？→ 直接 commit
  单文件 <50 行 + 无 API/架构变化？→ 直接改 + CHANGELOG
  配置/依赖变更？→ 验证 + CHANGELOG
  小功能（≤2 文件、无架构影响）？→ change-proposal.md
  多文件 / 新功能 / 架构变化？→ 完整 spec 流程
  不确定？→ 走 spec（安全侧）
```

## 完整 spec 流程（5 步）

```
proposal.md → 你确认 → design.md → 你确认 → tasks.md → 你确认 → 逐条实现 → verdict.md → 归档
```

每步确认后才进入下一步。不跳步。

## 工作区约定

- 活跃 spec：`specs/active/<spec-name>/`
- 已完成 spec：`specs/archive/<spec-name>/`
- 模板：`specs/template/`
- 治理：`docs/constitution.md`（不可违背）、`docs/project-rules.md`（项目特定）

## spec 生命周期

用文件存在性判断状态，不额外建状态文件：
- `proposal.md` + `design.md` 存在 → 方案待确认
- `tasks.md` 存在 → 方案已确认，待实现
- `verdict.md` 存在 → 待归档
- 在 `active/` → 未归档；在 `archive/` → 已归档

## CHANGELOG 规范

任何非纯文档的变更，在 commit 后更新 `CHANGELOG.md`。

格式：[Keep a Changelog](https://keepachangelog.com/)，语义化版本。

| 变更类型 | CHANGELOG 分类 |
|----------|---------------|
| 新功能 | `Added` |
| 已有功能改进 | `Changed` |
| Bug 修复 | `Fixed` |
| 移除功能 | `Removed` |
| 安全修复 | `Security` |

不需要更新 CHANGELOG 的情况：纯格式/注释修改、内部重构（行为无变化）、CI 配置微调。

## 何时不需要走 spec

- 纯文档修改 → 直接 commit
- 单文件 <50 行、无 API/架构变化 → 直接 fix + CHANGELOG
- 配置调参 → 验证 + CHANGELOG
- 依赖升级（小版本）→ 测试 + CHANGELOG

## 安全约定

- `.env` 不入 git
- 密钥由用户自行管理
- 高风险操作（删文件、推远程、改环境/CI/DB）须取得二次确认

## 项目特定规则

项目可在 `docs/project-rules.md` 中追加自己的规则。
Agent 启动时读取 `docs/project-rules.md`（如存在）。

## Sub-Skill 索引

当流程需要深入到具体阶段时，加载对应 skill：

| 阶段 | Skill | 何时加载 |
|------|-------|---------|
| 需求分析 | spec-proposal | 需要写 proposal.md |
| 技术方案 | spec-design | proposal 确认后需要写 design.md |
| 任务拆解 | spec-tasks | design 确认后需要写 tasks.md |
| 逐条实现 | spec-implement | tasks 确认后需要写代码 |
| 验收审查 | spec-review | 实现完成后需要验收 |
| 轻量变更 | change-proposal | 小改动不需要完整 spec |
| 自管理 | scaffold-manager | 安装/更新/检查脚手架 |
