#!/usr/bin/env ruby
require 'optparse'

# -a コマンドの実行結果 → 先頭に.がつくファイルも表示
def ls_a
  # カレントディレクトリ内にあるファイルを取得
  list1 = []
  list2 = []
  list3 = []
  Dir::entries(".").sort!.each.with_index(1) do |n, i|
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

# -l コマンドの実行結果 → 詳細表示
def ls_l
  puts "詳細表示"
end

# -r コマンドの実行結果 → 逆順表示
def ls_r
  puts "逆順表示"
end


if ARGV[0] == "ls" && ARGV[1] == "-a"
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
