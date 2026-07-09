# agent-scaffold

> 跨平台 Agent 脚手架：SDD 工作流 skills、自举安装、Anthropic Skills 标准

给编程 Agent 用的标准化工作流技能包。任何兼容 Anthropic Skills 标准的 Agent 工具都能安装使用。

**已支持 6 个平台**：QClaw、WorkBuddy、Claude Code、Trae、Codex、Generic

## 核心理念

1. **AGENTS.md 是第一入口** — Agent 启动时必读，Skills 是详细参考书
2. **脚手架与项目分离** — 脚手架是独立仓库，项目只保留 `.agent-scaffold.lock`
3. **Agent 自举** — 任何 Agent 首次进入项目时自动发现并安装
4. **跨平台兼容** — 源文件统一用 Anthropic Skills 标准，各平台提供安装适配脚本
5. **零工具依赖** — 纯 markdown + shell 脚本 + git

## 安装

### 在项目中使用

```bash
# 1. 创建项目（使用 spec-driven-project-template 或任何项目）
# 2. 安装脚手架
git clone https://github.com/LucasGuoo/agent-scaffold.git /tmp/agent-scaffold
bash /tmp/agent-scaffold/platforms/generic/install.sh /path/to/your/project
rm -rf /tmp/agent-scaffold
```

| 平台 | 安装目录 | 安装命令 |
|------|---------|----------|
| QClaw | `.agent/qclaw/skills/` | `bash platforms/qclaw/install.sh <project>` |
| WorkBuddy | `.agent/workbuddy/skills/` | `bash platforms/workbuddy/install.sh <project>` |
| Claude Code | `.claude/skills/` | `bash platforms/claude-code/install.sh <project>` |
| Trae IDE | `.trae/skills/` | `bash platforms/trae/install.sh <project>` |
| Codex | `.codex/skills/` | `bash platforms/codex/install.sh <project>` |
| 通用 | `.agent/skills/` | `bash platforms/generic/install.sh <project>` |

## Skills 列表

| Skill | 用途 | 触发场景 |
|-------|------|---------|
| `sdd-workflow` | **总路由器**：决策树 + CHANGELOG 规范 + spec 生命周期 | 任何编码请求 |
| `spec-proposal` | 需求分析 & 编写 proposal.md | 新功能、需求分析 |
| `spec-design` | 技术方案设计 & 编写 design.md | 架构设计 |
| `spec-tasks` | 任务拆解 & 编写 tasks.md | 开始实现前 |
| `spec-implement` | 按 tasks.md 逐条实现 | 编码 |
| `spec-review` | 验收审查 & 编写 verdict.md | 审查 |
| `change-proposal` | 轻量变更流（≤2 文件，无架构影响） | 小改进 |
| `scaffold-manager` | 脚手架自管理：安装/更新/卸载 | 安装/维护 |

## 目录结构

```
agent-scaffold/
├── AGENTS.md                 ← 脚手架自身的 Agent 入口
├── .agent-scaffold.lock      ← 版本锁模板
├── skills/                   ← Anthropic 标准 SKILL.md
│   ├── sdd-workflow/SKILL.md
│   ├── spec-proposal/SKILL.md
│   ├── spec-design/SKILL.md
│   ├── spec-tasks/SKILL.md
│   ├── spec-implement/SKILL.md
│   ├── spec-review/SKILL.md
│   ├── change-proposal/SKILL.md
│   └── scaffold-manager/SKILL.md
├── platforms/                ← 各平台安装脚本
│   ├── qclaw/install.sh
│   ├── workbuddy/install.sh
│   ├── claude-code/install.sh
│   ├── trae/install.sh
│   ├── codex/install.sh
│   └── generic/install.sh
├── templates/                ← spec 模板
│   ├── proposal.md
│   ├── design.md
│   ├── tasks.md
│   ├── verdict.md
│   ├── context.md
│   └── change-proposal.md
└── scripts/                  ← 维护脚本
    └── validate-skills.sh
```

## 版本

见 [CHANGELOG.md](CHANGELOG.md)

## License

MIT
