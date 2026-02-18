#!/bin/bash
set -euo pipefail

echo "🚀 ブランチ削除スクリプトを開始します..."

# 現在のブランチ名を取得
current_branch=$(git branch --show-current)
if [ -z "$current_branch" ]; then
  echo "⚠️ エラー: 現在のブランチを特定できませんでした。" >&2
  exit 1
fi
echo "🔍 現在のブランチ: $current_branch"

# 削除対象のブランチ一覧を取得
branches_to_delete=$(git branch --format '%(refname:short)' | grep -vE "^(main|release|study.*|$(git branch --show-current))$" || true)


if [ -z "$branches_to_delete" ]; then
  echo "✅ 削除対象のブランチはありません。"
  exit 0
fi

# 削除対象のブランチ一覧を表示
echo "🗑️ 以下のブランチが削除対象です:"
echo "$branches_to_delete"
echo ""

# ユーザーに確認
read -r -p "❓ 上記ブランチを削除しますか？ (y/N): " answer
case "$answer" in
  [yY][eE][sS]|[yY])
    echo "🔥 ブランチを削除します..."
    ;;
  *)
    echo "❌ 削除を中止しました。"
    exit 0
    ;;
esac

# 各ブランチを削除
while IFS= read -r branch; do
  # 空行は無視
  [ -z "$branch" ] && continue
  echo "🗑️ '$branch' を削除中..."

  if git branch -D "$branch"; then
    echo "✅ '$branch' を削除しました。"
  else
    echo "⚠️ '$branch' の削除に失敗しました。"
  fi

done <<< "$branches_to_delete"

echo "🎉 削除処理が完了しました。"
