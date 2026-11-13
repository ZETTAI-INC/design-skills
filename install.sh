#!/usr/bin/env bash
# design-skills を、どのフォルダでも使えるように自分の環境へ入れる。
#   bash install.sh                 Claude Code と Codex の両方に入れる
#   bash install.sh --claude        Claude Code だけ (~/.claude/skills)
#   bash install.sh --codex         Codex だけ (${CODEX_HOME:-~/.codex}/skills)
#   bash install.sh --link          コピーではなくリンクを張る（git pull で更新が反映される）
#   bash install.sh --force         同じ名前のスキルが既にあっても上書きする
#   bash install.sh --uninstall     このスクリプトで入れたスキルだけ削除する（--claude / --codex と併用可）
# このリポジトリのフォルダ内で Claude Code / Codex を使うだけなら、インストールは不要。
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MARK=".installed-by-design-skills"
want_claude=0; want_codex=0; LINK=0; FORCE=0; UNINSTALL=0
for a in "$@"; do
  case "$a" in
    --claude) want_claude=1 ;;
    --codex) want_codex=1 ;;
    --both) want_claude=1; want_codex=1 ;;
    --link) LINK=1 ;;
    --force) FORCE=1 ;;
    --uninstall) UNINSTALL=1 ;;
    -h|--help) sed -n '2,9p' "$0"; exit 0 ;;
    *) echo "不明なオプション: $a" >&2; exit 1 ;;
  esac
done
[ "$want_claude$want_codex" = "00" ] && { want_claude=1; want_codex=1; }

dests=()
[ "$want_claude" = 1 ] && dests+=("$HOME/.claude/skills")
[ "$want_codex" = 1 ] && dests+=("${CODEX_HOME:-$HOME/.codex}/skills")

skills=()
for d in "$ROOT"/skills/*/; do
  [ -f "$d/SKILL.md" ] && skills+=("$(basename "$d")")
done

for dest in "${dests[@]}"; do
  echo "== $dest"
  mkdir -p "$dest"
  for s in "${skills[@]}"; do
    target="$dest/$s"
    if [ "$UNINSTALL" = 1 ]; then
      # このスクリプトで入れたもの（目印ファイル付きのコピー、またはこのリポジトリへのリンク）だけ消す
      if [ -L "$target" ] && [ "$(readlink "$target")" = "$ROOT/skills/$s" ]; then
        rm "$target"; echo "  削除: $s"
      elif [ ! -L "$target" ] && [ -f "$target/$MARK" ]; then
        rm -rf "$target"; echo "  削除: $s"
      elif [ -e "$target" ]; then
        echo "  残しました（このスクリプトで入れたものではありません）: $s"
      fi
      continue
    fi
    if [ -e "$target" ] || [ -L "$target" ]; then
      if [ "$FORCE" = 1 ]; then rm -rf "$target"; else echo "  スキップ（既にあります。上書きは --force）: $s"; continue; fi
    fi
    if [ "$LINK" = 1 ]; then ln -s "$ROOT/skills/$s" "$target"; else cp -R "$ROOT/skills/$s" "$target" && : > "$target/$MARK"; fi
    echo "  入れました: $s"
  done
done
echo "完了しました。Claude Code / Codex を開き直すと読み込まれます。"
