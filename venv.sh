#!/bin/sh
# venv.sh (python3用の仮想環境の構築)

# 仮想環境のパス
venv=~wakita/lib/venv

[ -x /opt/anaconda3/bin/python ] && python3=opt/anaconda3/bin/python || \
[ -x /usr/local/bin/python3 ]    && python3=/usr/local/bin/python3

# 仮想環境の作成
$python3 -m venv $venv

# 仮想環境の有効化
. $venv/bin/activate

# 管理者以外にもファイルの読み込み権限，実行権限の許可
umask 022

# requirements.txt に記述されたパッケージのインストール
pip install --upgrade --requirement requirements.txt
