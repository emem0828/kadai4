#!/bin/bash

# テスト対象スクリプト
TARGET="./saidai.sh"

# テスト用関数
test_case() {
    description=$1
    input=$2
    expected=$3
    expect_error=$4

    echo -n "[TEST] $description ... "

    output=$($TARGET $input 2>&1)
    status=$?

    if [ "$expect_error" = "true" ]; then
        if [ $status -ne 0 ]; then
            echo "OK"
        else
            echo "NG（エラーが出るべきなのに成功した）"
            echo "出力: $output"
            exit 1
        fi
    else
        if [ $status -eq 0 ] && [ "$output" = "$expected" ]; then
            echo "OK"
        else
            echo "NG"
            echo "期待値: $expected"
            echo "実際の出力: $output"
            exit 1
        fi
    fi
}

# --- テスト開始 ---

# 正常系
test_case "2 と 4 の最大公約数は 2" "2 4" "2" false
test_case "15 と 25 の最大公約数は 5" "15 25" "5" false
test_case "7 と 13 の最大公約数は 1（互いに素）" "7 13" "1" false

# 異常系
test_case "引数が1つだけ → エラー" "3" "" true
test_case "文字列入力 → エラー" "a 5" "" true
test_case "0 を含む → エラー" "0 10" "" true
test_case "負数 → エラー" "-3 9" "" true

echo "テスト成功"
exit 0

