---
name: spec-proposal
description: >
  需求分析与 Spec Proposal 起草。
  用于定义新功能、分析需求、编写 specs/active/<name>/proposal.md。
  触发：新功能、spec、proposal、需求分析、设计方案、PRD。
version: 0.1.0
allowed-tools: read, write, edit
---

# Spec Proposal — 需求分析 & 方案起草

## 目标

编写符合 SDD 规范的 `specs/active/<spec-name>/proposal.md`。

## 前置条件

- 项目根目录存在 `.agent-scaffold.lock`（脚手架已安装）
- 已读取 `docs/constitution.md`（如存在）
- 不涉及 `specs/active/` 下同名的已有 spec

## 执行步骤

### Step 1: 需求理解

1. 向用户确认：**要解决什么问题？为什么现在做？**
2. 检查是否有相关的 ADR（`docs/adr/` 或 `docs/decisions/`）
3. 检查是否有相关的已有 spec（`specs/active/` 和 `specs/archive/`）

### Step 2: 范围对齐

1. 明确**做什么**和**不做什么**
2. 明确**影响范围**（哪些模块/文件会被改动）
3. 评估**风险等级**（低/中/高）

### Step 3: 命名 Spec

1. 使用 kebab-case 命名，如 `add-email-notification`、`refactor-auth-layer`
2. 确认不与其他活跃 spec 重名
3. 创建目录：`specs/active/<spec-name>/`

### Step 4: 起草 proposal.md

使用 `templates/proposal.md` 模板，填写以下内容：

1. **背景与动机** — 为什么需要这个变更
2. **目标** — 完成后达到什么效果
3. **范围** — 做什么、不做什么
4. **影响分析** — 涉及哪些文件/模块/服务
5. **风险评估** — 技术风险、时间风险、回滚策略
6. **参考资料** — 相关 issue、文档、ADR

### Step 5: 用户确认

1. 展示完整的 proposal.md 内容
2. **必须等用户确认后再进入下一阶段**（design 或 implement）
3. 用户确认后，proposal.md 即为「已批准」状态

## 输出

`specs/active/<spec-name>/proposal.md`

## 约束

- 不要同时开始写 design.md — 那是 spec-design 的职责
- 不要开始写代码 — 那是 spec-implement 的职责
- 如果 proposal 被拒绝或作废，移到 `specs/archive/` 并注明原因
