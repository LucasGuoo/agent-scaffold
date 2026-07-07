---
name: handoff
description: >
  Agent 间交接协议。当一个 Agent 完成工作、另一个 Agent 将接手时，
  编写交接文档确保上下文不丢失。git 是传递通道。
  触发：交接、handoff、切换工具、换 Agent、接力。
version: 0.1.0
allowed-tools: read, write, edit, exec
---

# Handoff — Agent 间交接协议

## 目标

确保 Agent/工具 之间的上下文无缝传递。

## 核心原则

**Git 即通道** — 交接文件提交到仓库，下一个 Agent `git pull` 获取。

## 何时写 handoff

| 场景 | 例子 |
|------|------|
| 工具切换 | QClaw 做了 spec-proposal，切换到 Claude Code 做实现 |
| 会话中断 | 同一个 Agent 但 session 被清除 |
| 并行协作 | Agent A 实现模块 1，Agent B 实现模块 2 |
| 异步接力 | 今天做不完，明天继续 |

## 执行步骤

### Step 1: 盘点当前状态

写清楚：
1. 当前 spec 名称和阶段
2. 已完成的任务（tasks.md 中哪些已勾选）
3. 待完成的任务
4. 当前的 git commit SHA

### Step 2: 起草 handoff.md

```markdown
# Handoff: <spec-name>

日期：YYYY-MM-DD HH:MM
来源 Agent：<tool-name>
目标 Agent：<下一个 Agent 及其工具>

## 当前状态

- Spec：specs/active/<name>/
- 阶段：proposal ✅ / design ✅ / tasks 进行中 (3/7)
- 最新 commit：abc1234

## 已完成

- [x] Task 1: xxx
- [x] Task 2: xxx
- [x] Task 3: xxx

## 待完成

- [ ] Task 4: xxx
- [ ] Task 5: xxx

## 注意事项

- 需要注意的坑：...
- 最近一次部署/测试的结果：...
- 特殊配置：...

## 下一步建议

1. 从 Task 4 开始
2. 完成后运行完整测试套件
3. 更新 CHANGELOG.md
```

### Step 3: 提交

1. commit handoff.md: `handoff(<spec-name>): Agent 交接`
2. 不要自动 push
3. 告知用户：交接文件已 ready

## 输出

`specs/active/<spec-name>/handoff.md`

## 给接手 Agent 的指示

1. `git pull origin main`
2. 读取 `specs/active/<name>/handoff.md`
3. 读取所有相关 spec 文件（proposal / design / tasks）
4. 从 handoff.md 中「下一步建议」开始工作
