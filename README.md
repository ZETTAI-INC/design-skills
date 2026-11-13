# design-skills

デザイン・UI と、文言（コピー）向けのスキル（AI への作業手順書）19個をまとめたリポジトリです。**Claude Code** と **Codex** の両方で使えます。

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
- 以前このスクリプトで入れたスキルは、もう一度実行すると新しい版に置き換わります。`git pull` の後に実行すれば更新できます。コピーで入れたスキルを手元で編集していた場合、その編集は上書きされて消えます。
- 自分で入れた同じ名前の別のスキルがある場合は、そのスキルを飛ばします。`--force` を付けると、元のスキルを `~/.claude/skills-backup/<日時>/`（Codex は `~/.codex/skills-backup/<日時>/`）へ退避してから入れ替えます。元のスキルは削除しません。
- 消すときは `bash install.sh --uninstall` を実行します。消えるのは、このスクリプトで入れたスキルだけです。
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
| UI の文言 | `ux-copy` | ボタン、エラー、空状態などの UI 文言 |
| 日本語の文言を正確にする | `ja-copy-polish` | **このリポジトリのオリジナル。** 倒置法、述語のない断片（「完全に。」）、「〜ではなく〜」の対比演出、誇張語、翻訳調など、AI 特有の日本語の書き癖を直す。景品表示法・薬機法に触れそうな表現（No.1、完全、絶対など）にも「要確認」を付ける |
| マーケの文言 | `copywriting` | LP・トップ・料金・機能ページなどの文言を新しく書く。見出し、CTA、価値の伝え方 |
| | `copy-editing` | 既にある文言を磨く、短くする、古い内容を更新する |
| | `stop-slop` | AI っぽい文章の癖を取り除く（英語向け。日本語は `ja-copy-polish`） |
| | `cro` | ページやフォームの成約率を上げる改善 |
| | `product-marketing` | 製品の立ち位置、対象者、ブランドの口調をまとめた土台の資料を作る。他の文言系スキルがこれを参照する |
| | `content-strategy` | ブログなどで何を書くかを計画する |
| ユーザー調査 | `user-research` | 調査の計画、インタビューガイド作成 |
| | `research-synthesis` | 調査結果をテーマや示唆にまとめる |

## 入手元とライセンス
`ja-copy-polish` 以外の各スキルは、公開リポジトリから、決まったコミットの版を取り込んでいます。詳細と変更点は [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md) を見てください。ライセンス全文は `licenses/` と、各スキルのフォルダの `LICENSE.txt` にあります。

## 注意
- Windows では、git の設定によっては `.claude/skills` と `.agents/skills` のリンクが正しく作られません。その場合は `bash install.sh`（Git Bash など）で入れてください。
- `ja-copy-polish` 以外のスキルは、第三者が公開しているものです。使う前に内容を確認することをおすすめします。
- `ja-copy-polish` の表示リスクの確認（景品表示法・薬機法など）は、明らかな危険を見つけるためのもので、法務の確認の代わりにはなりません。
- 一部のスキルは、このリポジトリに入っていない別のスキルの名前を案内します（`emails`、`signup`、`seo-audit`、`review-animations` など）。必要なら入手元のリポジトリから追加してください。
- `ui-ux-pro-max` の検索機能には Python 3 が必要です（`python3 --version` で確認できます）。
- `product-marketing` は、作業中のプロジェクトに `.agents/product-marketing.md`（製品の立ち位置などの資料）を作ります。このリポジトリの中で使った場合は `.gitignore` でコミットされないようにしてありますが、他のプロジェクトでは公開してよい内容か確認してください。
