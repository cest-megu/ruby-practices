#!/usr/bin/env ruby
require 'optparse'

def main
  opt = OptionParser.new
  params = {}
  opt.on('-l') { |v| params[:l] = v }
  opt.parse!(ARGV)

  ARGV.empty? ? output_from_stdin(params[:l]) : output_from_files(ARGV, params[:l])
end

def output_from_stdin(line_count_only)
  input = $stdin.read
  print_values(count_line(input), count_word(input), count_bytesize(input), nil, line_count_only)
end

def output_from_files(files, line_count_only)
  line_sum = 0
  word_sum = 0
  bytesize_sum = 0
  files.each do |file|
    input = File.read(file)
    line_count = count_line(input)
    line_sum += line_count
    word_count = count_word(input)
    word_sum += word_count
    bytesize_count = count_bytesize(input)
    bytesize_sum += bytesize_count
    print_values(line_count, word_count, bytesize_count, file, line_count_only)
  end
  print_values(line_sum, word_sum, bytesize_sum, 'total', line_count_only) if files.size > 1
end

def print_values(line_count, word_count, bytesize_count, file_name, line_count_only)
  print format_value(line_count)
  unless line_count_only
    print format_value(word_count)
    print format_value(bytesize_count)
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

def count_word(str)
  str.split(/\s+/).size
end

def count_bytesize(str)
  str.bytesize
end

def format_value(value)
  value.to_s.rjust(8)
end

main
