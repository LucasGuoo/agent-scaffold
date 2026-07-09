---
name: spec-implement
description: >
  按 tasks.md 逐条实现代码。
  严格遵循任务列表，完成一项勾选一项，不超出 scope。
  触发：实现、编码、写代码、implement、开发。
version: 0.1.0
allowed-tools: read, write, edit, exec
---

# Spec Implement — 按任务实现

## 目标

严格按照 `specs/active/<spec-name>/tasks.md` 逐条实现代码。

## 前置条件

- `specs/active/<spec-name>/tasks.md` 已确认
- `specs/active/<spec-name>/design.md` 已读取
- `specs/active/<spec-name>/proposal.md` 已读取

## 执行步骤

### Step 1: 准备工作

1. 读取完整的 spec 目录（proposal → design → tasks）
2. 检查 git status，确保工作区干净
3. 确认有 `context.md`（如有），了解当前上下文

### Step 2: 逐条实现

1. 按 tasks.md 的顺序，一次一条 task
2. 写完代码后：
   - 运行相关测试（如有）
   - 验证验收标准
3. 在 tasks.md 中将该条 task 的 checkbox 从 `[ ]` 改为 `[x]`
4. **每完成一群相关 task（如一组关联改动），commit 一次**

### Step 3: 完成所有 task 后

1. 运行一次完整的测试套件
2. 做一次自检：
   - 有没有超出 scope 的改动？
   - 有没有遗漏的 task？
   - 代码是否符合 `docs/constitution.md` 的规范？
3. 在 `tasks.md` 末尾补充任何接手者需要知道的上下文

### Step 4: 提交

1. 最后 commit：`spec(<spec-name>): 完成所有 tasks`
2. commit message 中引用 spec 名称
3. 不要自动 push — 等用户确认或审查

## 输出

- 代码变更（多个 commit）
- 更新后的 `tasks.md`（checkbox 已勾选，内附接手上下文）

## 约束

- 严格按 tasks.md 的顺序执行
- 不要超出 scope（不要"顺手"修不相关的东西）
- 不要跳过验收标准
- 尊重 `.gitignore`，不要提交不应提交的文件
