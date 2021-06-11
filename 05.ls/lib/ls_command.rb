#!/usr/bin/env ruby
require 'optparse'
require 'irb'
require 'etc'
class Dir
  attr_accessor :list_of_dir

  def initialize(list_of_dir:)
    @list_of_dir = list_of_dir
  end
end

# lsコマンドの実行結果→. や .. などのディレクトリや、ドットで始まるファイルは含まれない
@list_of_dir = Dir.glob("*").sort!

def ls
  list1 = []
  list2 = []
  list3 = []
  @list_of_dir.each.with_index(1) do |n, i|
    n += " " * [24 - n.length, 0].max
    if i % 3 == 1
      list1 << n
    elsif i % 3 == 2
      list2 << n
    else
      list3 << n
    end
  end

  puts list1.join("")
  puts list2.join("")
  puts list3.join("")
end

# -a コマンドの実行結果 → 先頭に.がつくファイルも表示
def ls_a
  # カレントディレクトリ内にあるファイルを取得
  @list_of_dir = Dir::entries(".").sort!
  ls
end

def ls_l
  files = []
  num_of_blocks = 0
  @list_of_dir.map do |file|
    # カレントディレクトリ内のファイルをそれぞれfiles配列に格納
    files << file
    num_of_blocks += File.stat(file).blocks
  end
  # ファイルのブロック数
  puts "total #{num_of_blocks}"

  files.map do |file|
    stat = File.stat(file)
    # binding.irb

    # パーミッション
    permission = stat.mode.to_s(8)
    #リンク数
    num_of_links = stat.nlink.to_s

    # binding.irb
    owner_name = Etc.getpwuid(Process.uid).name
    group = Etc.getgrgid(Process.gid).name
    byte_size = stat.size.to_s.rjust(4)
    timestamp = stat.mtime

    puts list = [permission, num_of_links, owner_name, group, byte_size, timestamp, file].join("  ")


  end

end

# -r コマンドの実行結果 → 逆順表示
def ls_r
  @list_of_dir = Dir.glob("*").sort!.reverse
  ls
end

# コマンドラインの指定
if ARGV[0] == "ls" && ARGV[1] == nil
  ls
elsif ARGV[0] == "ls" && ARGV[1] == "-a"
  ls_a
elsif ARGV[0] == "ls" && ARGV[1] == "-l"
  ls_l
elsif ARGV[0] == "ls" && ARGV[1] == "-r"
  ls_r
end






# ファイルクラス
# class File
#   attr_reader :file_type, :permission, :num_of_hardlink, :owner_name, :group, :byte_size, :timestamp, :file_name
#   def initialize(file_type, permission, num_of_hardlink, owner_name, group, byte_size, timestamp, file_name)
#     @file_type = file_type
#     @permission = permission
#     @num_of_hardlink = num_of_hardlink
#     @owner_name = owner_name
#     @group = group
#     @byte_size = byte_size
#     @timestamp = timestamp
#     @file_name = file_name
#   end
# end

# # ファイルクラスの配列
# files = [File.new, File.new, File.new]
