#!/bin/bash

# 引数が2つではない場合、スクリプトの使用方法を表示して終了
if [ $# -ne 2 ]; then
    echo "Usage: $0 <command> <subject_file>"
    exit 1
fi

# コマンドと被験者番号が記載されたファイル名を引数から取得
command=$1
subject_file=$2

# ファイルが存在しない場合、エラーメッセージを表示して終了
if [ ! -f "$subject_file" ]; then
    echo "Error: File '$subject_file' does not exist."
    exit 2
fi

# ファイルの各行を読み込み、読み込んだ行に対してコマンドを実行
while IFS= read -r subject_id
do
    $command "$subject_id"
done < "$subject_file"

