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

# 04 10 12 といった文字列を引数にとって、 d - l を返す処理
def file_type_char(file_type)
  filetype = {
    '04' => 'd',
    '10' => '-',
    '12' => 'l'
  }
  filetype[file_type]
end

# パーミッションを表す数字を文字列に変換する処理
def permission_change(permission_array, some_permission)
  some_permission.map do |p|
    permission = {
      '0' => '---',
      '1' => '--x',
      '2' => '-w-',
      '3' => '-wx',
      '4' => 'r--',
      '5' => 'r-x',
      '6' => 'rw-',
      '7' => 'rwx'
    }
    permission_array << permission[p]
  end
end

def show_files(files)
  files.map do |file|
    stat = File.stat(file)
    permission = stat.mode.to_s(8) # パーミッション ８進数で表す
    permission = format('%06d', permission) # ８進数の桁数を６桁にあわせる
    m = /(\d{2})(\d{1})(\d{1})(\d{1})(\d{1})/.match(permission) # ８進数を5つに分解

    permission_array = []
    file_type = file_type_char(m[1])
    permission_change(permission_array, m[3..5])

    permission = file_type + permission_array.join('') # パーミッションを記号で表す
    num_of_links = stat.nlink.to_s # リンク数
    owner_name = Etc.getpwuid(Process.uid).name # オーナー名
    group = Etc.getgrgid(Process.gid).name # グループ名
    byte_size = stat.size.to_s.rjust(4) # ファイルサイズ
    timestamp = stat.mtime # タイムスタンプ
    puts [permission, num_of_links, owner_name, group, byte_size, timestamp, file].join('  ')
  end
end

def ls_l
  files = []
  num_of_blocks = 0
  @list_of_dir.map do |file|
    files << file # カレントディレクトリ内のファイルをそれぞれfiles配列に格納
    num_of_blocks += File.stat(file).blocks
  end
  puts "total #{num_of_blocks}" # ファイルのブロック数

  show_files(files)
end

# コマンドラインの指定
params = {}
opt = OptionParser.new

opt.on('-a') { |v| params[:a] = v }
opt.on('-r') { |v| params[:r] = v }
opt.on('-l') { |v| params[:l] = v }

opt.parse!(ARGV)

@list_of_dir = params[:a] ? Dir.entries('.').sort : Dir.glob('*').sort
@list_of_dir = @list_of_dir.reverse if params[:r]
params[:l] ? ls_l : ls
