# design-skills

デザインと UI 向けのスキル（AI への作業手順書）12個をまとめたリポジトリです。**Claude Code** と **Codex** の両方で使えます。

## 使い方

### 1. clone する
```bash
git clone https://github.com/ZETTAI-INC/design-skills.git
cd design-skills
```

### 2-A. このフォルダの中で使う（インストール不要）
clone したフォルダで Claude Code か Codex を起動すれば、そのまま使えます。
- Claude Code は `.claude/skills/` を読み込みます。
- Codex は `.agents/skills/` を読み込みます。
- どちらも `skills/` へのリンクです。

### 2-B. どのプロジェクトでも使う（おすすめ）
```bash
bash install.sh            # Claude Code と Codex の両方に入れる
bash install.sh --claude   # Claude Code だけ
bash install.sh --codex    # Codex だけ
bash install.sh --link     # コピーの代わりにリンクを張る。git pull で更新が反映される
```
- 入れる先
  - Claude Code：`~/.claude/skills/`
  - Codex：`~/.codex/skills/`（`CODEX_HOME` を設定していればその下）
- 同じ名前のスキルが既にある場合は飛ばします。上書きするときは `--force` を付けます。
- 消すときは `bash install.sh --uninstall` を実行します。
- 入れた後は、Claude Code / Codex を開き直してください。

### 呼び出し方
- **Claude Code**：`/frontend-design` のように `/スキル名` で呼ぶか、内容に合う依頼をすると自動で読み込まれます。
- **Codex**：`$frontend-design` のようにスキル名で指定するか、内容に合う依頼をすると自動で使われます。

## 入っているスキル

| やりたいこと | スキル | 内容 |
|---|---|---|
| 新しい画面・LP を作る | `frontend-design` | テンプレ臭くない、意図のある見た目を作るための指針 |
| | `ui-ux-pro-max` | スタイル、配色、フォント、UX ガイドラインを検索できる設計データベース。Python 3 が必要 |
| 動き・触り心地 | `animate` | Web（React など）のアニメーションを、判断の順序に沿って作る |
| | `animate-expo` | React Native / Expo のアニメーション、ジェスチャー、ハプティクス |
| | `apple-design` | Apple 流の滑らかな動きとインターフェース設計を Web 向けに翻訳したもの |
| レビュー | `design-critique` | デザイン案へのフィードバック（使いやすさ、視覚的な階層、一貫性） |
| | `accessibility-review` | WCAG 2.1 AA に沿ったアクセシビリティ確認 |
| 開発に渡す | `design-handoff` | 寸法、トークン、状態、挙動をまとめた開発向け仕様書 |
| | `design-system` | デザインシステムの監査、文書化、拡張 |
| 文言 | `ux-copy` | ボタン、エラー、空状態などの UI 文言 |
| ユーザー調査 | `user-research` | 調査の計画、インタビューガイド作成 |
| | `research-synthesis` | 調査結果をテーマや示唆にまとめる |

## 入手元とライセンス
各スキルは公開リポジトリから、決まったコミットの版を取り込んでいます。詳細と変更点は [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md) を、ライセンス全文は `licenses/` を見てください。

## 注意
- Windows では、git の設定によっては `.claude/skills` と `.agents/skills` のリンクが正しく作られません。その場合は `bash install.sh`（Git Bash など）で入れてください。
- スキルの中身は第三者が公開しているものです。使う前に内容を確認することをおすすめします。
