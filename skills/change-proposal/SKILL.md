---
name: change-proposal
description: >
  轻量变更流，用于小功能改进、单文件变更、无架构影响的修改。
  不需要完整的 proposal→design→tasks 流程，只记录 delta。
  触发：小改动、小改进、轻量变更、change proposal、quick fix。
version: 0.1.0
allowed-tools: read, write, edit
---

# Change Proposal — 轻量变更流

## 目标

对小规模变更（≤2 文件、无架构变化、无新增 API），用最少的文书工作记录变更意图。

## 适用场景

- Bug 修复中涉及设计决策
- 单文件重构
- 配置调整（有行为变化的）
- UI 文案/样式微调
- 性能微优化

## 不适用场景

以下情况应走完整 SDD 流程（spec-proposal → spec-design → spec-tasks）：

- 多文件变更（>2 文件）
- 新增 API 或数据结构
- 架构变化
- 新增依赖
- 影响多个模块

## 执行步骤

### Step 1: 确认适用

检查是否满足「轻量」条件：
- [ ] 变更涉及 ≤ 2 个文件
- [ ] 无新增 API 或数据结构
- [ ] 无架构变化
- [ ] 无新增依赖
- [ ] 不影响多个模块

不满足任一条件 → 回退到完整 SDD 流程

### Step 2: 命名

创建目录：`specs/active/<change-name>/`

命名规则：`fix-xxx` / `improve-xxx` / `adjust-xxx`

### Step 3: 起草 change-proposal.md

```markdown
# Change Proposal: <name>

日期：YYYY-MM-DD

## 现状

（当前的行为或状态是什么？为什么需要改？）

## 变更

（具体改什么？）

## 影响

- 涉及文件：...
- 有无行为变化：有 / 无
- 有无 API 变化：有 / 无

## 验证

（怎么确认改对了？）
```

### Step 4: 执行 + 记录

1. 完成变更
2. 在 change-proposal.md 末尾记录「已完成 YYYY-MM-DD」
3. 更新 CHANGELOG.md（加载 changelog-update skill）
4. commit: `change(<name>): <简要描述>`

## 输出

`specs/active/<change-name>/change-proposal.md`

## 约束

- 不要滥用轻量流 — 不确定时走完整 SDD
- 每个 change-proposal 仍然要有明确的验证方式
- 完成后仍然要更新 CHANGELOG.md
