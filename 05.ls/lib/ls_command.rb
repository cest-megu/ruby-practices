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

def ls
  list1 = []
  list2 = []
  list3 = []
  @list_of_dir.each.with_index(1) do |n, i|
    n += ' ' * [24 - n.length, 0].max
    case i % 3
    when 1
      list1 << n
    when 2
      list2 << n
    when 0
      list3 << n
    end
  end

  puts list1.join('')
  puts list2.join('')
  puts list3.join('')
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
    # パーミッション ８進数で表す
    permission = stat.mode.to_s(8)
    # ８進数の桁数を６桁にあわせる
    permission = format('%06d', permission)
    # ８進数を5つに分解
    m = /(\d{2})(\d{1})(\d{1})(\d{1})(\d{1})/.match(permission)
    file_type = m[1] # 1文字目のファイルの種類（タイプ）
    some_permission = m[3..5] # owner,group, otherのパーミッション

    case m[1]
    when '04'
      file_type = 'd'
    when '10'
      file_type = '-'
    when '12'
      file_type = 'l'
    end

    permission_array = []

    some_permission.map do |p|
      case p
      when '0'
        p = '---'
      when '1'
        p = '--x'
      when '2'
        p = '-w-'
      when '3'
        p = '-wx'
      when '4'
        p = 'r--'
      when '5'
        p = 'r-x'
      when '6'
        p = 'rw-'
      when '7'
        p = 'rwx'
      end
      permission_array << p
    end

    # パーミッションを記号で表す
    permission = file_type + permission_array.join('')
    # リンク数
    num_of_links = stat.nlink.to_s
    # オーナー名
    owner_name = Etc.getpwuid(Process.uid).name
    # グループ名
    group = Etc.getgrgid(Process.gid).name
    # ファイルサイズ
    byte_size = stat.size.to_s.rjust(4)
    # タイムスタンプ
    timestamp = stat.mtime

    puts [permission, num_of_links, owner_name, group, byte_size, timestamp, file].join('  ')
  end
end

# コマンドラインの指定
params = {}
opt = OptionParser.new

opt.on('-a') { |v| params[:a] = v }
opt.on('-r') { |v| params[:r] = v }
opt.on('-l') { |v| params[:l] = v }

opt.parse!(ARGV)

@list_of_dir = Dir.entries('.').sort!.reverse
if params[:a] && params[:r] && params[:l]
  ls_l
elsif params[:a] && params[:r]
  ls
elsif params[:a] && params[:l]
  @list_of_dir = Dir.entries('.').sort!
  ls_l
elsif params[:r] && params[:l]
  @list_of_dir = Dir.glob('*').sort!.reverse
  ls_l
elsif params[:a]
  @list_of_dir = Dir.entries('.').sort!
  ls
elsif params[:r]
  @list_of_dir = Dir.glob('*').sort!.reverse
  ls
elsif params[:l]
  @list_of_dir = Dir.glob('*').sort!
  ls_l
end
