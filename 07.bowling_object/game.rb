#!/usr/bin/env ruby
# frozen_string_literal: true

require './frame'
class Game
  attr_reader :game_score

  def initialize(game_score = ARGV[0])
    @game_score = game_score
  end

  def split_one_shot
    "#{game_score}".split(',')
  end
end

game_score = Game.new(ARGV[0])
game_scores = game_score.split_one_shot

# 数字に変換
marks = []
game_scores.each do |s|
  if s == 'X' # strike
    marks << 10
    marks << 0
  else
    marks << s.to_i
  end
end

# フレームごとに分割
@frame = Frame.new(first_shot, second_shot, third_shot)
frames = []
# 10フレーム目は2投ではなく3投の可能性があること考慮
marks.first(18).each_slice(2) do |m|
  frames << m
end
frames << marks.drop(18)

point = 0
frames.each.with_index do |_frame, i|
  point +=  if i != 9 # 最終フレーム以外
              if frames[i].strike? && frames[i + 1].strike? # ダブルストライク
                case i
                when 0..7 # フレーム１〜８の時
                  10 + 10 + frames[i + 2][0]
                when 8 # フレーム９の時
                  10 + 10 + frames[i + 1][2]
                end
              elsif frames[i].strike? && frames[i + 1].strike? == false # ストライク
                10 + frames[i + 1][0] + frames[i + 1][1]
              elsif frames[i].spare?
                10 + frames[i + 1][0]
              else
                frames[i].score
              end
            else # 最終フレームの時
              frames[i].score # 最終フレームは全て足し算
            end
end
