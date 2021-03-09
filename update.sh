cd txx-server.git                               
                                                 
sh venv.sh                                          # Python3 仮想環境の構築    
sh js.sh                                            # JavaScript の収集
mkdir -p ~wakita/data && cp -r data/* ~wakita/data  # データのコピー

                           
chown -R wakita ~wakita/data ~wakita/lib
