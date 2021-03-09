#!/bin/sh

if [ $USER != "wakita" ]; then echo "please sudo wakita first, before you run this script"; fi

if [ "$1" = test ]; then export KWHOME=/tmp; else export KWHOME=/home/wakita-lab/wakita; fi
export DATA=$KWHOME/data
export SHARE=$KWHOME/share
export REPOSITORY="$SHARE/`date +server-%Y-%m-%d`"
#echo $KWHOME; exit 0

# 作業用ディレクトリを作成して，そこに移動
mkdir -p $SHARE; cd $SHARE

# 設定データを展開
git clone https://github.com/smartnova/txx-server.git $REPOSITORY
cd $REPOSITORY

sh venv.sh                                          # Python3 仮想環境の構築
sh js.sh                                            # JavaScript の収集
mkdir -p $DATA && cp -r data/* $DATA                # データのコピー
