#!/usr/bin/env ruby

require 'irb'

# 引数をとり、１投ごとに分割する
score = ARGV[0]
scores = score.split(',')

# 数字に変換
shots = []
scores.each do |s|
  if s == 'X' # strike
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end


# フレーム毎に分割
frames = []

# shotsの数が20の時(最後のフレームが2投で終わる時)
if shots.length == 20
  shots.each_slice(2) do |s|
    frames << s
  end
else
# 最後のフレームが3投で終わる時
  shots.first(18).each_slice(2) do |s|
    frames << s
  end
  if shots.length == 21
    frames << shots.last(3)
  else
  # 最後のフレームの3投目がストライクで終わる時
    frames << shots.last(4)
  end
end

# binding.irb

p frames

# スペア分とストライク分を加算する
point = 0
frames.each do |frame|
  if frame[0] == 10 # strike
    point += frame.sum + 10
  elsif frame.sum == 10 # spare
    point += frame[0] + 10
  else
    point += frame.sum
  end
end

puts point
