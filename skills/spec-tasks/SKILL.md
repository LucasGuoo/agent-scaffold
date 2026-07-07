---
name: spec-tasks
description: >
  任务拆解，编写 specs/active/<name>/tasks.md。
  将 design.md 中的方案拆分为可逐条执行的 task 列表。
  触发：任务拆解、tasks、实现计划、todo、checklist。
version: 0.1.0
allowed-tools: read, write, edit
---

# Spec Tasks — 任务拆解

## 目标

在 proposal.md 和 design.md 已确认的前提下，将实现方案拆解为可逐条执行的 task 列表。

## 前置条件

- `specs/active/<spec-name>/proposal.md` 已确认
- `specs/active/<spec-name>/design.md` 已确认

## 执行步骤

### Step 1: 阅读 design.md

1. 识别所有需要变更的文件
2. 识别所有新增的文件
3. 识别依赖变更

### Step 2: 拆解任务

按依赖关系排序，每条 task 用 checkbox 标记：

```markdown
### Task 1: 创建数据模型
- [ ] 新建 `src/models/xxx.py`
  - 字段：A、B、C
  - 验证规则：...
- 验收：单元测试通过

### Task 2: 实现 API 接口
- [ ] 新增 `POST /api/xxx` 路由
  - 请求格式：...
  - 响应格式：...
  - 错误处理：400/404/500
- 验收：集成测试通过 + curl 手动验证

### Task N: 清理与文档
- [ ] 更新 `CHANGELOG.md`
- [ ] 更新相关 README
- [ ] 删除调试代码
- 验收：代码审查通过
```

### Step 3: 粒度原则

- 每条 task 应在 1 小时内可完成
- 每条 task 必须有明确的验收标准
- 每条 task 必须写清楚涉及的文件路径
- 依赖关系：前面的 task 完成后，后面的 task 才能开始

### Step 4: 用户确认

展示 tasks.md，确认：
1. 任务覆盖是否完整
2. 任务顺序是否合理
3. 验收标准是否足够明确

## 输出

`specs/active/<spec-name>/tasks.md`

## 约束

- design 未确认 → 不能开始 tasks
- 每条 task 必须可独立验收
- 不要开始写代码 — 那是 spec-implement 的职责
