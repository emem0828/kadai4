#!/bin/bash

# 入力チェック
if [ $# -ne 2 ]; then
    echo "Error: 引数は2つの自然数を指定してください。" >&2
    exit 1
fi

# 正の整数かチェック（0や負数、文字列を排除）
if ! [[ $1 =~ ^[1-9][0-9]*$ ]] || ! [[ $2 =~ ^[1-9][0-9]*$ ]]; then
    echo "Error: 自然数のみ入力できます。" >&2
    exit 1
fi

a=$1
b=$2

# 最大公約数の計算
while [ $b -ne 0 ]; do
    temp=$b
    b=$((a % b))
    a=$temp
done

echo $a
exit 0

