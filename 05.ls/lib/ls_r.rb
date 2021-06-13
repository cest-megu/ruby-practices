# -r コマンドの実行結果 → 逆順表示
def ls_r
  @list_of_dir = Dir.glob("*").sort!.reverse
  ls
end
