#!/usr/bin/env ruby
require 'optparse'
require 'irb'

# 行数を取得
def line_count(str)
  str.lines.count
end

# 単語数を取得
def words_count(str)
  str.split(/\s/).reject(&:empty?).size
end

# バイト数を取得
def bytesize(str)
  str.bytesize
end

# 行数のみ
def wc_l
  list = []
  total_list = []
  sum_of_line = 0
  ARGV.each do |file|
    sum_of_line += line_count(File.read(file))
    list = [line_count(File.read(file)).to_s.rjust(8), file] # wc ファイル名の結果を配列に
    puts list.join(" ")
    total_list =[sum_of_line.to_s.rjust(8), "total"] # totalの結果
  end
  puts total_list.join(" ") if ARGV[1] != nil
end

# wc ファイル名で、行数、単語数、バイト数、ファイル名を表す
def wc
  list = []
  total_list = []
  sum_of_line = 0
  sum_of_words = 0
  sum_of_bytesize = 0
  ARGV.each do |file|
    sum_of_line += line_count(File.read(file))
    sum_of_words += words_count(File.read(file))
    sum_of_bytesize += bytesize(File.read(file))
    # wc ファイル名の結果を配列に
    list = [line_count(File.read(file)).to_s.rjust(8), words_count(File.read(file)).to_s.rjust(8), bytesize(File.read(file)).to_s.rjust(8), file]
    puts list.join(" ")
    total_list =[sum_of_line.to_s.rjust(8), sum_of_words.to_s.rjust(8), sum_of_bytesize.to_s.rjust(8), "total"]
  end
  puts total_list.join(" ") if ARGV[1] != nil
end

# 標準入力を受け取り、文字列でinputに保存する
def show_data
  input = $stdin.read
  print line_count(input).to_s.rjust(8)
  print words_count(input).to_s.rjust(8)
  print bytesize(input).to_s.rjust(8)
  print "\n"
end

# コマンドラインの指定
opt = OptionParser.new
params = {}
# オプションの引数
opt.on('-l') {|v| params[:l] = v }

opt.parse!(ARGV)
p ARGV # ファイル名を指定した時
p params # params[:l] => ファイル名

if ARGV.empty? # ファイル指定なし（標準入力）
  show_data
else # ファイル指定あり
  params[:l] ? wc_l : wc
end
