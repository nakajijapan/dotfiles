#!/bin/bash

# 対象のブランチを取得
branches=$(git branch --format '%(refname:short)' | grep -vE "^(main|release|study.*|$(git branch --show-current))$")

# 対象のブランチがない場合
if [ -z "$branches" ]; then
  echo "削除対象のブランチはありません。"
  exit 0
fi

# 削除対象のブランチを表示
echo "以下のブランチを削除対象としています:"
echo "$branches"
echo ""

# 確認プロンプト
read -p "これらのブランチを削除しますか？ (yes/no): " confirm

if [ "$confirm" != "yes" ]; then
  echo "削除処理を中止しました。"
  exit 0
fi

# 削除処理を実行
echo "削除を実行します..."
echo "$branches" | xargs -n 1 git branch -D
echo "削除が完了しました。"
