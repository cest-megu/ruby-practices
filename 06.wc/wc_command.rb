#!/usr/bin/env ruby
require 'optparse'
require 'irb'

# 行数のみ
def wc_l
  list = []
  total_list = []
  sum_of_line = 0
  ARGV.each do |file|
    content_of_file = File.read(file)
    line_count = content_of_file.lines.count # 行数
    sum_of_line += line_count
    # wc ファイル名の結果を配列に
    list = [line_count.to_s.rjust(8), file]
    puts list.join(" ")
    total_list =[sum_of_line.to_s.rjust(8), "total"]
  end
  puts total_list.join(" ") if ARGV[1] != nil
end

# wc ファイル名で、行数、単語数、バイト数、ファイル名を表す
def wc_file
  list = []
  total_list = []
  sum_of_line = 0
  sum_of_words = 0
  sum_of_bytesize = 0
  ARGV.each do |file|
    content_of_file = File.read(file)
    line_count = content_of_file.lines.count # 行数
    sum_of_line += line_count
    num_of_words = content_of_file.split(/\s/).reject(&:empty?).size # 単語数
    sum_of_words += num_of_words
    bytesize = content_of_file.bytesize # バイト数
    sum_of_bytesize += bytesize
    # wc ファイル名の結果を配列に
    list = [line_count.to_s.rjust(8), num_of_words.to_s.rjust(8), bytesize.to_s.rjust(8), file]
    puts list.join(" ")
    total_list =[sum_of_line.to_s.rjust(8), sum_of_words.to_s.rjust(8), sum_of_bytesize.to_s.rjust(8), "total"]
  end
  puts total_list.join(" ") if ARGV[1] != nil
end

# コマンドラインの指定
opt = OptionParser.new
params = {}

# オプションの引数
opt.on('-l') {|v| params[:l] = v }

opt.parse!(ARGV)
p ARGV # ファイル名を指定した時
p params # params[:l] => ファイル名

params[:l] ? wc_l : wc_file

binding.irb
