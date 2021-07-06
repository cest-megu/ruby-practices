#!/usr/bin/env ruby
require 'optparse'

def main
  opt = OptionParser.new
  params = {}
  opt.on('-l') { |v| params[:l] = v }
  opt.parse!(ARGV)

  ARGV.empty? ? read_stdin : wc(ARGV, params[:l])
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

def print_values(line, words, bytesize, file_name, params)
  print format_value(line)
  unless params
    print format_value(words)
    print format_value(bytesize)
  end
  print ' '
  print file_name
  print "\n"
end

def read_stdin
  input = $stdin.read
  print_values(count_line(input), count_words(input), count_bytesize(input), nil, nil)
end

def wc(files, params)
  line_sum = 0
  words_sum = 0
  bytesize_sum = 0
  files.each do |file|
    input = File.read(file)
    line_count = count_line(input)
    line_sum += line_count
    words_count = count_words(input)
    words_sum += words_count
    bytesize_count = count_bytesize(input)
    bytesize_sum += bytesize_count
    print_values(line_count, words_count, bytesize_count, file, params)
  end
  print_values(line_sum, words_sum, bytesize_sum, 'total', params) if files.size > 1
end

main
