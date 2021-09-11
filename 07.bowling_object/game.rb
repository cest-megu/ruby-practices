
class Game
  attr_reader :game_score

  def initialize(game_score = ARGV[0])
    @game_score = game_score
  end

  # ストライク、スペアのときボーナスポイント
  def

  end

  # ただ足すだけ
  def score

  end

end

# ARGV[0]
game_score = Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5')
puts game_scores = game_score.split(',')
