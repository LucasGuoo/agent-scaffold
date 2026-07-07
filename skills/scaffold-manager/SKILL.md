---
name: scaffold-manager
description: >
  脚手架自管理。处理 agent-scaffold 的安装、更新、卸载和健康检查。
  当 Agent 首次进入项目或需要维护脚手架时使用。
  触发：安装脚手架、更新脚手架、scaffold install、scaffold update、
  scaffold check、check scaffold。
version: 0.1.0
allowed-tools: read, write, exec
---

# Scaffold Manager — 脚手架自管理

## 目标

让任何 Agent 能够自主完成脚手架的安装、更新、卸载和健康检查。

## 操作类型

### install — 首次安装

1. 读取项目根目录或模板提供的 `.agent-scaffold.lock`
2. 从 lock 文件中的 `scaffold.repo` 克隆脚手架到临时目录
3. 检测当前 Agent 平台并运行对应安装脚本
4. 写入 `.agent-scaffold.lock`（记录版本和 SHA）
5. 输出安装摘要

```
git clone <scaffold.repo> /tmp/agent-scaffold-<timestamp>
bash /tmp/agent-scaffold-<timestamp>/platforms/<platform>/install.sh <project-root>
```

### update — 更新脚手架

1. 读取 `.agent-scaffold.lock` 中的当前版本
2. 检查远程仓库最新 tag
3. 如果有新版本：
   - MINOR/PATCH → 自动更新
   - MAJOR → 提示用户确认
4. 重新运行 install 脚本
5. 更新 `.agent-scaffold.lock`

```
cd /tmp/agent-scaffold-<timestamp>
git fetch --tags
latest_tag=$(git describe --tags --abbrev=0)
# 比对当前版本和 latest_tag
```

### check — 健康检查

1. 检查 `.agent/` 目录是否存在
2. 检查 `.agent/<platform>/skills/` 是否包含 SKILL.md 文件
3. 检查 lock 文件中的版本是否与 `.agent/` 中的一致
4. 输出健康报告

### uninstall — 卸载

1. 删除 `.agent/` 目录
2. 删除 `.agent-scaffold.lock`（或清空内容）
3. 输出卸载确认

## 支持平台

| 平台 | 安装脚本路径 |
|------|-------------|
| QClaw | `platforms/qclaw/install.sh` |
| Claude Code | `platforms/claude-code/install.sh` |
| Codex | `platforms/codex/install.sh` |
| 通用 | `platforms/generic/install.sh` |

## 平台检测

按以下顺序检测当前平台：

```
1. 环境中有 qclaw 命令 → QClaw
2. 环境中有 claude 命令且 .claude/ 目录存在 → Claude Code
3. 环境中有 codex 命令 → Codex
4. 都不满足 → Generic
```

## 输出

- 操作后的 `.agent-scaffold.lock`（install / update）
- 健康检查报告（check）
- 卸载确认（uninstall）

## 约束

- install 和 update 后必须更新 `.agent-scaffold.lock`
- update 前必须确认 git 工作区干净
- 不要自动删除 `.agent/` 目录 — 只通过 uninstall 操作删除
- 不要修改脚手架源仓库 — 脚手架的更新通过 git pull 获取
