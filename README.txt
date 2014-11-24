dockerコンテナ管理用シェルスクリプト

start_all_container.sh
  全コンテナ起動用スクリプト(statusがExitになっているコンテナを全て起動)

stop_all_container.sh
  全コンテナ停止用スクリプト(statusがUpになっているコンテナを全て停止)

run_images.sh  
  docker run用スクリプト(引数が3つだとポートマッピングなし。4つだとポートマッピングあり。)
  ※コンテナ内の/root/service.shを起動時に自動実行する。
    書式: run_images.sh [コンテナ名] [コンテナにつけるホスト名] [元にするイメージ名] [ポートマッピング]"

  　
