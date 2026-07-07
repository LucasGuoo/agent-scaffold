---
name: spec-review
description: >
  独立审查已完成的 spec 实现，输出 verdict（通过/修改/驳回）。
  审查者必须独立于实现者。
  触发：审查、review、验收、检查、verdict、code review。
version: 0.1.0
allowed-tools: read, edit, exec
---

# Spec Review — 独立审查

## 目标

独立审查已完成的 spec 实现，输出单一最终决策。

## 前置条件

- `tasks.md` 中所有 checkbox 已勾选
- 代码已 commit
- 审查者**不是**实现者（如果是同一个 Agent 做审查，必须先声明此限制）

## 执行步骤

### Step 1: 读取上下文

1. 读取完整 spec 目录（proposal → design → tasks）
2. 读取实际代码变更（`git diff main...HEAD` 或类似）
3. 读取 `docs/constitution.md`（如存在）

### Step 2: 逐项审查

按以下清单逐一检查：

| 检查项 | 通过条件 |
|--------|----------|
| 范围一致性 | 改动不超出 proposal 定义的范围 |
| 任务完整性 | 每条 task 的验收标准都满足 |
| 代码质量 | 符合项目编码规范 |
| 错误处理 | 异常路径有处理 |
| 测试覆盖 | 关键路径有测试 |
| 文档更新 | CHANGELOG / README 已更新 |
| 宪法合规 | 不违反 `docs/constitution.md` |

### Step 3: 输出 verdict

`specs/active/<spec-name>/verdict.md`：

```markdown
# Verdict: <spec-name>

审查日期：YYYY-MM-DD
审查者：<agent/tool>

## 决策

✅ **通过** — 可以合并 / 部署

或

⚠️ **通过（有建议）** — 可以合并，但有改进建议（非阻塞）

或

❌ **驳回** — 不可合并，原因如下：

### 驳回原因

1. ...

### 建议

1. ...
```

### Step 4: 处理结果

- **通过** → 标记 spec 为完成，建议归档
- **通过（有建议）** → 记录建议，不阻塞合并
- **驳回** → 实现者根据 verdict 修改后重新走 review

## 输出

`specs/active/<spec-name>/verdict.md`

## 约束

- 审查者必须独立（不同 Agent 或不同会话）
- verdict 只能有一个明确决策
- 驳回时必须写清楚具体原因和修复建议
