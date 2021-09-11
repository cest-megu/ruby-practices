require 'minitest/autorun'
require './shot'

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
