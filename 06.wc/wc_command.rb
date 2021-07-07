#!/usr/bin/env ruby
require 'optparse'

def main
  opt = OptionParser.new
  params = {}
  opt.on('-l') { |v| params[:l] = v }
  opt.parse!(ARGV)

  ARGV.empty? ? read_input(params[:l]) : output(ARGV, params[:l])
end

def read_input(params_boolean)
  input = $stdin.read
  print_values(count_line(input), count_words(input), count_bytesize(input), nil, params_boolean)
end

def output(files, params_boolean)
  line_sum = 0
  word_sum = 0
  bytesize_sum = 0
  files.each do |file|
    input = File.read(file)
    line_count = count_line(input)
    line_sum += line_count
    word_count = count_words(input)
    word_sum += word_count
    bytesize_count = count_bytesize(input)
    bytesize_sum += bytesize_count
    print_values(line_count, word_count, bytesize_count, file, params_boolean)
  end
  print_values(line_sum, words_sum, bytesize_sum, 'total', params_boolean) if files.size > 1
end

def print_values(line, words, bytesize, file_name, params_boolean)
  print format_value(line)
  unless params_boolean
    print format_value(words)
    print format_value(bytesize)
  end
  if file_name
    print ' '
    print file_name
  end
  print "\n"
end

def count_line(str)
  str.lines.count
end

def count_words(str)
  str.split(/\s+/).size
end

def count_bytesize(str)
  str.bytesize
end

def format_value(value)
  value.to_s.rjust(8)
end

main
