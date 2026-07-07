---
name: sdd-workflow
description: >
  SDD 工作流总路由器。根据改动规模和复杂度，自动选择最小且诚实的流程深度。
  所有涉及代码变更的请求必须先经过此路由器判断。
  触发：任何编码、新功能、bugfix、重构、配置变更请求。
version: 0.1.0
---

# SDD Workflow Router

## 目的

对任何涉及项目文件变更的请求，先判断该走什么流程，再执行。

## 决策树

收到编码请求后，按以下顺序判断：

```
1. 纯文档变更（README、注释、docs/）？
   → 直接执行，更新 CHANGELOG.md
   → 完成

2. 单文件 < 50 行变更 + 无 API 变化 + 无新增依赖？
   → 直接 fix，更新 CHANGELOG.md
   → 完成

3. 配置/依赖变更（CI、package.json、Cargo.toml 等）？
   → 验证变更合理性，更新 CHANGELOG.md
   → 完成

4. 小功能改进（≤2 文件，无架构变更，无新 spec 目录）？
   → 加载 change-proposal skill
   → 完成

5. 多文件 / 新功能 / 架构变更 / API 变化 / 数据模型变化？
   → 走完整 SDD 流程：
     a) spec-proposal → 需求分析
     b) spec-design → 技术方案
     c) spec-tasks → 任务拆解
     d) spec-implement → 实现
     e) spec-review → 验收
   → 完成

6. 无法判断规模？
   → 默认走完整 SDD（安全侧），避免遗漏
   → 完成
```

## 工作区约定

- 所有活跃的 spec 放在 `specs/active/<spec-name>/`
- 已完成的 spec 移到 `specs/archive/<spec-name>/`
- 每个 spec 目录下至少有 `proposal.md`
- 设计文档放在 `specs/active/<spec-name>/design.md`（如有）
- 任务列表放在 `specs/active/<spec-name>/tasks.md`（如有）
- 审查报告放在 `specs/active/<spec-name>/verdict.md`（如有）

## 调用方式

当 Agent 工具支持自动技能路由时，本 skill 的 `description` 中的触发关键词可自动匹配。

如果工具不支持自动路由，Agent 应在收到编码请求时手动读取本文件。
