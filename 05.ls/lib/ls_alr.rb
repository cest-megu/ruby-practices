# -alr コマンドの実行結果

def ls_alr
  @list_of_dir = Dir.glob("*").sort!.reverse
  ls_l
end
