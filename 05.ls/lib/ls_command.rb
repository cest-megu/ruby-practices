#!/usr/bin/env ruby
require 'optparse'

# -a コマンドの実行結果 → 先頭に.がつくファイルも表示
def ls_a
  puts "先頭に.がつくファイル表示"

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
end

if ARGV[0] == "ls" && ARGV[1] == "-l"
  ls_l
end

if ARGV[0] == "ls" && ARGV[1] == "-r"
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
