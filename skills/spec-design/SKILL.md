---
name: spec-design
description: >
  技术方案设计，编写 specs/active/<name>/design.md。
  用于在 proposal 确认后制定技术实现方案。
  触发：技术方案、architecture、design、设计文档、系统设计。
version: 0.1.0
allowed-tools: read, write, edit, web_search
---

# Spec Design — 技术方案设计

## 目标

在 proposal.md 已确认的前提下，编写 `specs/active/<spec-name>/design.md`。

## 前置条件

- `specs/active/<spec-name>/proposal.md` 已存在且用户已确认
- 已读取 proposal 内容
- 已读取 `docs/constitution.md`（如存在）

## 执行步骤

### Step 1: 方案调研

1. 阅读相关代码，理解现有架构
2. 如有必要，搜索行业最佳实践
3. 识别至少 2 个可能的实现方案

### Step 2: 方案比较

对每个备选方案，写清楚：

| 维度 | 方案 A | 方案 B |
|------|--------|--------|
| 实现复杂度 | ... | ... |
| 性能影响 | ... | ... |
| 维护成本 | ... | ... |
| 与现有架构的一致性 | ... | ... |

### Step 3: 起草 design.md

1. **概述** — 一句话描述技术方案
2. **推荐方案** — 详细描述选定的方案，包括：
   - 架构图（文字描述或 mermaid）
   - 数据流
   - 关键数据结构/接口定义
   - 错误处理策略
3. **备选方案** — 为什么没选
4. **文件变更清单** — 新增、修改、删除的文件
5. **依赖变更** — 新增/更新/删除的依赖
6. **测试策略** — 单元测试、集成测试、手动验收

### Step 4: 用户确认

1. 展示完整的 design.md 内容
2. **必须等用户确认后再进入实现阶段**
3. 如果设计被要求修改，更新 design.md 并重新确认

## 输出

`specs/active/<spec-name>/design.md`

## 约束

- proposal 未确认 → 不能开始 design
- 必须提供至少一个备选方案
- 必须包含错误处理策略
- 不要开始写代码 — 那是 spec-implement 的职责
