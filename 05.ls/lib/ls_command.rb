#!/usr/bin/env ruby
require 'optparse'
require 'irb'

# 他ファイル参照
require_relative 'ls_a'
require_relative 'ls_l'
require_relative 'ls_r'
require_relative 'ls_alr'
class Dir
  attr_accessor :list_of_dir

  def initialize(list_of_dir:)
    @list_of_dir = list_of_dir
  end
end

# lsコマンドの実行結果→. や .. などのディレクトリや、ドットで始まるファイルは含まれない
@list_of_dir = Dir.glob('*').sort!

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

# コマンドラインの指定

case ARGV[0]
when 'ls'
  if ARGV[1].nil?
    ls
  elsif ARGV[1] == '-a'
    ls_a
  elsif ARGV[1] == '-r'
    ls_r
  elsif ARGV[1] == '-l'
    ls_l
  elsif /-[alr]{3}/.match?(ARGV[1])
    ls_alr
  end
end
