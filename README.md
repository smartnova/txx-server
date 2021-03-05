# txx-server

以下をサーバで実行して下さい．
~~~
# 作業用ディレクトリの作成
tmpdir=$(mktemp -d /tmp/wakita-`date "+%Y-%m-%d-%Hh%Mm"`) && cd $tmpdir                                           

# 設定データのダウンロード
git clone https://github.com/smartnova/txx-server.git

# 設定スクリプトの実行
cd txx-server; sh update.sh

# 作業用ディレクトリの消去
cd /tmp && rm -rf $tmpdir
~~~
