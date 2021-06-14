#!/usr/bin/env ruby
# frozen_string_literal: true

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

# フレームごとに分割
frames = []
# 10フレーム目は2投ではなく3投の可能性があること考慮
shots.first(18).each_slice(2) do |s|
  frames << s
end
frames << shots.drop(18)

p frames

# スペア分とストライク分を考慮してポイント加算
# フレーム９番目と最終フレームのみ、加算方法が異なる
point = 0

frames.each.with_index do |_frame, i|
  point += case i
           when 0..7 # フレーム１〜８の時
             if frames[i][0] == 10 && frames[i + 1][0] == 10 # strikeが２連続
               10 + 10 + frames[i + 2][0]
             elsif frames[i][0] == 10 && frames[i + 1][0] != 10 # strikeが１回のみ
               10 + frames[i + 1][0] + frames[i + 1][1]
             elsif frames[i].sum == 10 # spare
               10 + frames[i + 1][0]
             else
               frames[i].sum
             end
           when 8 # フレーム９の時
             if frames[i].first == 10 && frames[i + 1][0] == 10 && frames[i + 1][2] == 10 # strikeが3連続
               10 + 10 + 10
             elsif frames[i].first == 10 && frames[i + 1][0] != 10 # strikeが１回のみ
               10 + frames[i + 1][0] + frames[i + 1][1]
             elsif frames[i].sum == 10 # spare
               10 + frames[i + 1][0]
             else
               frames[i].sum
             end
           else # 最終フレームの時
             frames[i].sum # 最終フレームは全て足し算
           end
end

puts point
