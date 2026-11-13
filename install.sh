#!/usr/bin/env bash
# design-skills を、どのフォルダでも使えるように自分の環境へ入れる。
#   bash install.sh                 Claude Code と Codex の両方に入れる
#   bash install.sh --claude        Claude Code だけ (~/.claude/skills)
#   bash install.sh --codex         Codex だけ (${CODEX_HOME:-~/.codex}/skills)
#   bash install.sh --link          コピーではなくリンクを張る（git pull で更新が反映される）
#   bash install.sh --force         同じ名前の別のスキルがあれば、~/.claude/skills-backup/ などへ退避して入れ替える
# 以前このスクリプトで入れたものは、もう一度実行すると新しい版に置き換わる（git pull の後の更新に使う）。
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
    -h|--help) sed -n '2,10p' "$0"; exit 0 ;;
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

# このスクリプトで入れたものか：目印ファイル付きのコピー、このリポジトリへのリンク、
# またはリポジトリを移動したなどで壊れた「…/skills/<名前>」へのリンク
ours() {
  local t="$1" s="$2"
  if [ -L "$t" ]; then
    local to; to="$(readlink "$t")"
    [ "$to" = "$ROOT/skills/$s" ] && return 0
    [ ! -e "$t" ] && [ "${to%/skills/$s}" != "$to" ] && return 0
    return 1
  fi
  [ -d "$t" ] && [ -f "$t/$MARK" ]
}

STAMP="$(date +%Y%m%d-%H%M%S)"
for dest in "${dests[@]}"; do
  echo "== $dest"
  mkdir -p "$dest"
  backup="$(dirname "$dest")/skills-backup/$STAMP"
  for s in "${skills[@]}"; do
    target="$dest/$s"
    if [ "$UNINSTALL" = 1 ]; then
      if ours "$target" "$s"; then
        rm -rf "$target"; echo "  削除: $s"
      elif [ -e "$target" ] || [ -L "$target" ]; then
        echo "  残しました（このスクリプトで入れたものではありません）: $s"
      fi
      continue
    fi
    if [ -e "$target" ] || [ -L "$target" ]; then
      if ours "$target" "$s"; then
        rm -rf "$target"   # 以前このスクリプトで入れたものは、新しい版で置き換える
      elif [ "$FORCE" = 1 ]; then
        # 自分で入れた同名スキルは消さずに退避する（スキルとして読み込まれない場所へ）
        mkdir -p "$backup"; mv "$target" "$backup/$s"; echo "  退避しました: $s → $backup/$s"
      else
        echo "  スキップ（同じ名前の別のスキルがあります。退避して入れ替えるなら --force）: $s"; continue
      fi
    fi
    if [ "$LINK" = 1 ]; then ln -s "$ROOT/skills/$s" "$target"; else cp -R "$ROOT/skills/$s" "$target" && : > "$target/$MARK"; fi
    echo "  入れました: $s"
  done
done
echo "完了しました。Claude Code / Codex を開き直すと読み込まれます。"
