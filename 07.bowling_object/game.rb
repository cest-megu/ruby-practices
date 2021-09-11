
class Game
  attr_reader :game_score

  def initialize(game_score = ARGV[0])
    @game_score = game_score
  end

  def to_s
    "#{game_score}"
  end

  def to_frame
    "#{game_score}".split(',')
  end

  # ストライク、スペアのときボーナスポイント

  # ただ足すだけ
  def score

  end

end
