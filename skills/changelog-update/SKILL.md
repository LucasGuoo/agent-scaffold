---
name: changelog-update
description: >
  更新 CHANGELOG.md，遵循 Keep a Changelog 格式。
  任何非纯文档的变更完成后都应触发。
  触发：更新日志、changelog、变更记录、发布说明。
version: 0.1.0
allowed-tools: read, write, edit
---

# Changelog Update — 变更日志更新

## 目标

按照 [Keep a Changelog](https://keepachangelog.com/zh-CN/1.0.0/) 格式，
在每次有意义的变更后更新项目根目录的 `CHANGELOG.md`。

## 何时触发

| 变更类型 | CHANGELOG 分类 |
|----------|---------------|
| 新功能 / 新文件 / 新能力 | `Added` |
| 已有功能的改进 | `Changed` |
| 废弃功能（即将移除） | `Deprecated` |
| 移除功能 | `Removed` |
| Bug 修复 | `Fixed` |
| 安全修复 | `Security` |

以下情况**不需要**更新：
- 纯格式/注释/文档修改（README 修正、代码注释）
- 内部重构（行为无变化）
- CI 配置微调（行为无变化）

## 执行步骤

### Step 1: 确定变更内容

1. 如果是 spec 驱动，读取 spec 的 proposal + design
2. 如果是轻量变更，读取 change-proposal
3. 如果是纯 fix，确认修复了什么

### Step 2: 确定分类

按上表选择正确的分类。

### Step 3: 写入 CHANGELOG

在 `CHANGELOG.md` 的 `[Unreleased]` 段落中，按分类添加条目：

```markdown
## [Unreleased]

### Added
- 新功能描述。([#123](https://github.com/...))
- 引用 spec 名称：`specs/archive/<spec-name>/`

### Fixed
- 修复了 xxx 问题
```

规则：
- 每条一行，以 `- ` 开头
- 如果有 GitHub issue/PR，附上链接
- 如果有 spec，附上 spec 路径

### Step 4: 版本发布时

当用户要求发布新版本时：
1. 将 `[Unreleased]` 替换为 `[MAJOR.MINOR.PATCH] - YYYY-MM-DD`
2. 添加空行
3. 新增一个空的 `[Unreleased]` 段落

## 输出

- 更新后的 `CHANGELOG.md`

## 约束

- 不要创建新的 changelog 格式（坚持 Keep a Changelog）
- 不要猜测版本号 — 让用户决定何时 bump
- 不要删除历史条目
