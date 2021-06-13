# -aコマンドの実行結果 → 先頭に.がつくファイルも表示
def ls_a
  # カレントディレクトリ内にあるファイルを取得
  @list_of_dir = Dir.entries('.').sort!
  ls
end
