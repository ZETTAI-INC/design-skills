# 第三者のスキルと、そのライセンス

このリポジトリの `skills/` 以下は、すべて次の公開リポジトリから取り込んだものです。各ライセンスの全文は `licenses/` にあります。

| スキル | 入手元（固定したコミット） | ライセンス |
|---|---|---|
| animate, animate-expo, apple-design | [emilkowalski/skills](https://github.com/emilkowalski/skills/tree/f7ce8c02d6e3c8f0d980a44c57bcc41a40254349) `skills/<名前>` | MIT（Copyright (c) 2026 Emil Kowalski） |
| ui-ux-pro-max | [nextlevelbuilder/ui-ux-pro-max-skill](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill/tree/6ae86f61f520d6ca229d2f40e070410638c908c5) `.claude/skills/ui-ux-pro-max` | MIT |
| frontend-design | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official/tree/f75f5b25ae94f4332be4ff5f18435741d2589bdb) `plugins/frontend-design/skills/frontend-design` | Apache License 2.0 |
| accessibility-review, design-critique, design-handoff, design-system, research-synthesis, user-research, ux-copy | [anthropics/knowledge-work-plugins](https://github.com/anthropics/knowledge-work-plugins/tree/02717ef04446b6ef5aa4b8af15bb536d79f42ed0) `design/skills/<名前>` | Apache License 2.0 |

## このリポジトリで加えた変更
プラグインの外でも、Claude Code と Codex の両方で動くようにするため、次の変更を加えました。

- **ui-ux-pro-max**
  - `SKILL.md`：スクリプトのパス `${CLAUDE_PLUGIN_ROOT}/.claude/skills/ui-ux-pro-max/` を `$SKILL_DIR/` に置き換えた。あわせて、`$SKILL_DIR` の意味を説明する段落を追加した。
  - `scripts/tests/` を削除した。
- **design 系の7スキル**（accessibility-review ほか）：元のプラグインの `design/CONNECTORS.md` を各スキルのフォルダにコピーした。`SKILL.md` 内のリンク `../../CONNECTORS.md` は `CONNECTORS.md` に書き換えた。
- その他のファイルは、入手元のまま変更していません。
