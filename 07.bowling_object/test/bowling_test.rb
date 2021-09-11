require 'minitest/autorun'
require './shot'
require './frame'
require './game'

class ShotTest < Minitest::Test
  def test_shot
    shot1 = Shot.new('X')
    assert_equal 'X', shot1.mark
    assert_equal 10, shot1.score

    shot2 = Shot.new('3')
    assert_equal '3', shot2.mark
    assert_equal 3, shot2.score
  end
end

class FrameTest < Minitest::Test
  def test_frame
    frame1 = Frame.new('6', '4', 'X')
    assert_equal 20, frame1.score

    # ストライクのとき
    frame2 = Frame.new('X')
    assert frame2.strike?

    # スペアのとき
    frame3 = Frame.new('3', '7')
    assert frame3.spare?
  end
end


class GameTest < Minitest::Test
  def test_game
    game_score = Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5')
    p game_scores = game_score.to_frame
  end
end
