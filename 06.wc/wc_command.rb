#!/usr/bin/env ruby
require 'optparse'

def main
  opt = OptionParser.new
  @params = {}
  opt.on('-l') { |v| @params[:l] = v }
  opt.parse!(ARGV)

  ARGV.empty? ? read_stdin : wc(ARGV)
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

def wc(files)
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
    list1 = [format_value(line_count), ' ', file]
    list2 = [
      format_value(line_count),
      format_value(words_count),
      format_value(bytesize_count),
      ' ',
      file
    ]
    if @params[:l]
      puts list1.join('')
    else
      puts list2.join('')
    end
  end
  total_list1 = [format_value(line_sum), ' ', 'total']
  total_list2 = [
    format_value(line_sum),
    format_value(words_sum),
    format_value(bytesize_sum),
    ' ',
    'total'
  ]
  if files.size > 1
    if @params[:l]
      puts total_list1.join('')
    else
      puts total_list2.join('')
    end
  end
end

def read_stdin
  input = $stdin.read
  print format_value(count_line(input))
  print format_value(count_words(input))
  print format_value(count_bytesize(input))
  print "\n"
end

def format_value(value)
  value.to_s.rjust(8)
end

main
